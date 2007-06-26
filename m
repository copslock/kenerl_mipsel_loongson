Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2007 22:10:30 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.171]:19296 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022141AbXFZVKZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Jun 2007 22:10:25 +0100
Received: by ug-out-1314.google.com with SMTP id m3so197152ugc
        for <linux-mips@linux-mips.org>; Tue, 26 Jun 2007 14:10:25 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=tRot5kA5Mrt5FR0CPfBrqhA2u+ydD4MzuZhHix9Vy1leLzv32dT6fl2tPFNJ/VvFix/5l0/5fRFbKq5O7DdXApIqbsjAyyRWZZnk0pOTvAHcLVRpEv/P/ekvFPd1x9oae9R5fV1sEvjPsDaOxaqr9di27SmuVPr/lbzwHQSL/HU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=S3rNY3heI9AJjnSBwpGH9DfxBj/2mBwf0RCZbxsSq1yic9jbPsIKoW+1uQBZjGPcCL+rjbHGHT6L3W+AxsAzI+f6/X3yygjfD9RICl0SspEC2ALDPbsXh7WV64tYmfK9TIbqq08R9i9cfOXWdB7w0miihV+RM1mWEumhoUZcjVg=
Received: by 10.66.242.20 with SMTP id p20mr638119ugh.1182892225111;
        Tue, 26 Jun 2007 14:10:25 -0700 (PDT)
Received: from gmail.com ( [217.67.117.64])
        by mx.google.com with ESMTP id m1sm1156965uge.2007.06.26.14.10.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jun 2007 14:10:24 -0700 (PDT)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Wed, 27 Jun 2007 01:10:47 +0400 (MSD)
Date:	Wed, 27 Jun 2007 01:10:45 +0400
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	ralf@linux-mips.org, akpm@osdl.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] mips-jazz: correct flags for timer io resource
Message-ID: <20070626211045.GA5801@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

arch/mips/jazz/setup.c:55:4: error: Initializer entry defined twice

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/jazz/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/jazz/setup.c
+++ b/arch/mips/jazz/setup.c
@@ -54,7 +54,7 @@ static struct resource jazz_io_resources[] = {
 		.start	= 0x40,
 		.end	= 0x5f,
 		.name	= "timer",
-		.end	= IORESOURCE_BUSY
+		.flags	= IORESOURCE_BUSY
 	}, {
 		.start	= 0x80,
 		.end	= 0x8f,
