import streamlit as st
import pandas as pd
import torch
import numpy as np

torch.classes.__path__ = []

# Show a image in the app
st.title("Hello Streamlit")
st.subheader("This is a subheader")
st.write("This is a write command")
st.text("This is a text command")
st.text(f'torch version: {torch.__version__}')
st.text(f'numpy version: {np.__version__}')
st.markdown("This is a markdown command")
