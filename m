Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 15:39:16 +0100 (WEST)
Received: from fg-out-1718.google.com ([72.14.220.156]:12002 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022294AbZFDOjJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 15:39:09 +0100
Received: by fg-out-1718.google.com with SMTP id d23so1644737fga.9
        for <multiple recipients>; Thu, 04 Jun 2009 07:39:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=toED3fZ9sPo6bovVY8unblz7aWZFAGUxT3+0iLIMj80=;
        b=rf/M9z4WKlNV39C1l24C+7q1kc3duF0+jPc6oeaPmb+DneMW9SXcVlnxKBb1HwC4G9
         3MOiM+klrRm3Dj/YG8u+dr9l1l8NTI8geb72t/4FIYyT7Oihqx1/aYzwDGT05SfbsE/M
         j9P1gMG13t7Epn897mRVDA6KULa0SP6+mmaqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CQGQ3/5X0pL7gCLmRrcvXaSYIW4h2ikAdb9XQuVnCZCYegzz5es5HnwlDD0J2PtTkQ
         493Q8zu25s+WRnWxe6c1xrlTnVY5vsTKjbh2WQ9hca6bNaa6dT+iEzaZ19lo3K+rrX+K
         ojjh5I68Y/wUk7kIJxdiHA1jtLfo1hY9gCWh4=
Received: by 10.86.59.18 with SMTP id h18mr2629451fga.44.1244126347650;
        Thu, 04 Jun 2009 07:39:07 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id d6sm1922331fga.2.2009.06.04.07.39.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 07:39:07 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/8] add lib/gcd.c
Date:	Thu, 4 Jun 2009 16:39:03 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>
References: <200906041615.10467.florian@openwrt.org> <4A27DAAD.5000303@ru.mvista.com>
In-Reply-To: <4A27DAAD.5000303@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906041639.04868.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Sergei,

Le Thursday 04 June 2009 16:31:09 Sergei Shtylyov, vous avez écrit :
> Hello.
>
> Florian Fainelli wrote:
> > This patch adds lib/gcd.c which contains a greatest
> > common divider implementation taken from
> > sound/core/pcm_timer.c
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
>
> [...]
>
> > diff --git a/lib/gcd.c b/lib/gcd.c
> > new file mode 100644
> > index 0000000..fbf81a8
> > --- /dev/null
> > +++ b/lib/gcd.c
> > @@ -0,0 +1,20 @@
> > +#include <linux/gcd.h>
> > +#include <linux/module.h>
> > +
> > +/* Greatest common divisor */
> > +unsigned long gcd(unsigned long a, unsigned long b)
> > +{
> > +	unsigned long r;
> > +
> > +	if (a < b) {
> > +		r = a;
> > +		a = b;
> > +	b = r;
>
>     Fix indentation please.

Fixed in the following version. Also putting David in copy since it
he was not in copy of the first patch and could not know why there
is a following patch on net/netfilter/ipvs/ip_vs_wrr.c to use lib/gcd.c
--
From: Florian Fainelli <florian@openwrt.org>

This patch adds lib/gcd.c which contains a greatest
common divider implementation taken from
sound/core/pcm_timer.c

Changes from v1:
- fixed indentation
- use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL as
suggested by Ralf Baechle

Signed-off-by: Florian Fainelli <florian@openwrt.org>
--
diff --git a/include/linux/gcd.h b/include/linux/gcd.h
new file mode 100644
index 0000000..69f5e8a
--- /dev/null
+++ b/include/linux/gcd.h
@@ -0,0 +1,8 @@
+#ifndef _GCD_H
+#define _GCD_H
+
+#include <linux/compiler.h>
+
+unsigned long gcd(unsigned long a, unsigned long b) __attribute_const__;
+
+#endif /* _GCD_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 8ade0a7..70a9906 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -10,6 +10,9 @@ menu "Library routines"
 config BITREVERSE
 	tristate
 
+config GCD
+	bool
+
 config GENERIC_FIND_FIRST_BIT
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 33a40e4..389bdd2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_CRC_ITU_T)	+= crc-itu-t.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_CRC7)	+= crc7.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
+obj-$(CONFIG_GCD)	+= gcd.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
diff --git a/lib/gcd.c b/lib/gcd.c
new file mode 100644
index 0000000..6634741
--- /dev/null
+++ b/lib/gcd.c
@@ -0,0 +1,20 @@
+#include <linux/gcd.h>
+#include <linux/module.h>
+
+/* Greatest common divisor */
+unsigned long gcd(unsigned long a, unsigned long b)
+{
+	unsigned long r;
+
+	if (a < b) {
+		r = a;
+		a = b;
+		b = r;
+	}
+	while ((r = a % b) != 0) {
+		a = b;
+		b = r;
+	}
+	return b;
+}
+EXPORT_SYMBOL_GPL(gcd);
