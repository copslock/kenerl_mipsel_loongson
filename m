Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 13:16:52 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.183]:45267
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225218AbVBDNQ3>; Fri, 4 Feb 2005 13:16:29 +0000
Received: from [212.227.126.207] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1Cx3Jz-0004lR-00; Fri, 04 Feb 2005 14:16:27 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1Cx3Jz-0000Db-00; Fri, 04 Feb 2005 14:16:27 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] au1100fb.c ported from 2.4 to 2.6
Date:	Fri, 4 Feb 2005 14:18:47 +0100
User-Agent: KMail/1.7.1
References: <1105523407.5654.18.camel@absolute.ascensit.com> <200502021005.18589.eckhardt@satorlaser.com> <1107511003.5266.11.camel@absolute.ascensit.com>
In-Reply-To: <1107511003.5266.11.camel@absolute.ascensit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041418.47589.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Christian wrote:
> First you have to modify the function au1100fb_setcolreg, add the switch
> case for 4bpp. Look in the Alchemy manual for the format of the palette
> in the 4 bpp case. Then look for my comment "TODO: 8bbp", put a switch
> and for pseudocolor like visual ... I think this is not even necessary.

Thanks, will look.

> More important is that you change the monitor type. 

Yep, finding working parameters without real knowledge of what the registers 
mean was the hardest part, but I have it working now.

> If you want I can 
> send you privately a patch this weekend, but I just cannot assure it
> works, you have to test it and eventually contribute.

I'd appreciate that, thank you.



Currently I'm facing a different problem though, look at this code and the 
bitmap it generates (4bpp):

   unsigned long* fb = my_fb_info->fb_virt_start;
   fb[0]   = 0x0000000f; // *.......
   fb[40]  = 0x000000f0; // .*......
   fb[80]  = 0x000000ff; // **......
   fb[120] = 0xf0000f00; // ..*....*
   fb[160] = 0xff000f0f; // *.*...**
   fb[200] = 0xfff00ff0; // .**..***
   fb[240] = 0xffff0fff; // ***.****

To me, expecting the LSB to be part of the leftmost pixel is not really 
surprising, but functions like cfb_fillrect() (or rather bitfill32() etc) 
expect the order to be the other way around. I'm afraid that other 
framebuffer functions also expect that, but I haven't gotten far enough to 
test those. I only tested cfb_fillrect() and, seeing it fail, started looking 
for answers... any idea?



I stumbled across another .. err .. 'feature': take a look at the appended 
patch, in particular the handling of the mask for the first long, am I 
dreaming or is this in fact handled wrongly in the current FB code? I'm a bit 
confused, because the same mistake is made in pretty much every FB driver I 
looked at.

Thanks

Uli

---

Index: cfbcopyarea.c
===================================================================
RCS file: /home/cvs/linux/drivers/video/cfbcopyarea.c,v
retrieving revision 1.10
diff -u -w -r1.10 cfbcopyarea.c
--- cfbcopyarea.c 12 Oct 2004 01:45:47 -0000 1.10
+++ cfbcopyarea.c 4 Feb 2005 13:11:16 -0000
@@ -70,7 +70,7 @@
   } else {
    // Multiple destination words
    // Leading bits
-   if (first) {
+   if (first != ~0UL) {
     
     FB_WRITEL((FB_READL(src) & first) | 
        (FB_READL(dst) & ~first), dst);
@@ -223,7 +223,7 @@
   } else {
    // Multiple destination words
    // Leading bits
-   if (first) {
+   if (first != ~0UL) {
     FB_WRITEL((FB_READL(src) & first) | (FB_READL(dst) & ~first), dst); 
     dst--;
     src--;
Index: cfbfillrect.c
===================================================================
RCS file: /home/cvs/linux/drivers/video/cfbfillrect.c,v
retrieving revision 1.8
diff -u -w -r1.8 cfbfillrect.c
--- cfbfillrect.c 12 Oct 2004 01:45:47 -0000 1.8
+++ cfbfillrect.c 4 Feb 2005 13:11:16 -0000
@@ -142,7 +142,7 @@
  } else {
   // Multiple destination words
   // Leading bits
-  if (first) {
+  if (first != ~0UL) {
    FB_WRITEL(comp(val, FB_READL(dst), first), dst);
    dst++;
    n -= BITS_PER_LONG-dst_idx;
@@ -166,7 +166,7 @@
   
   // Trailing bits
   if (last)
-   FB_WRITEL(comp(val, FB_READL(dst), first), dst);
+   FB_WRITEL(comp(val, FB_READL(dst), last), dst);
  }
 }
 
@@ -197,7 +197,7 @@
  } else {
   // Multiple destination words
   // Leading bits
-  if (first) {
+  if (first != ~0UL) {
    FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
    dst++;
    pat = pat << left | pat >> right;
@@ -224,7 +224,7 @@
   
   // Trailing bits
   if (last)
-   FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
+   FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
  }
 }
 
@@ -252,7 +252,7 @@
  } else {
   // Multiple destination words
   // Leading bits
-  if (first) {
+  if (first != ~0UL) {
    dat = FB_READL(dst);
    FB_WRITEL(comp(dat ^ val, dat, first), dst);
    dst++;
@@ -287,7 +287,7 @@
   // Trailing bits
   if (last) {
    dat = FB_READL(dst);
-   FB_WRITEL(comp(dat ^ val, dat, first), dst);
+   FB_WRITEL(comp(dat ^ val, dat, last), dst);
   }
  }
 }
@@ -320,7 +320,7 @@
  } else {
   // Multiple destination words
   // Leading bits
-  if (first) {
+  if (first != ~0UL) {
    dat = FB_READL(dst);
    FB_WRITEL(comp(dat ^ pat, dat, first), dst);
    dst++;
@@ -354,7 +354,7 @@
   // Trailing bits
   if (last) {
    dat = FB_READL(dst);
-   FB_WRITEL(comp(dat ^ pat, dat, first), dst);
+   FB_WRITEL(comp(dat ^ pat, dat, last), dst);
   }
  }
 }
