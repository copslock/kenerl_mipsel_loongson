From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 31 May 2010 19:58:18 +0200
Subject: [PATCH] mips: fix build with O=...
Message-ID: <20100531175818.YGilxzbD8keS4047ojQoK8Al-NBAZaM7jJigsvCNXfo@z>

The newly added platform support introduced
a regression so build with O=... failed.

Fix this by prefixing Makefile include paths with $(srctree).

Reported-by: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Hi Manuel.
Thanks for testing and reporting so quick.
The following fixed it for me - I tried only the ar7 platfrom.
And do not hesitate to ask if you hit troubles converting your
platform.

Note: On top of my tree since git did not see the
git tree posted by Ralf as a git tree?!?

	Sam

 arch/mips/Kbuild.platforms |    2 +-
 arch/mips/Makefile         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 932f268..681b2d4 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -3,4 +3,4 @@
 platforms += ar7
 
 # include the platform specific files
-include $(patsubst %, arch/mips/%/Platform, $(platforms))
+include $(patsubst %, $(srctree)/arch/mips/%/Platform, $(platforms))
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index c2e1068..ff71a54 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -209,7 +209,7 @@ endif
 #
 # Board-dependent options and extra files
 #
-include arch/mips/Kbuild.platforms
+include $(srctree)/arch/mips/Kbuild.platforms
 
 #
 # Acer PICA 61, Mips Magnum 4000 and Olivetti M700.
-- 
1.6.0.6
