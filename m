Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 16:07:33 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.191]:50738 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021496AbXGKPHb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 16:07:31 +0100
Received: by mu-out-0910.google.com with SMTP id w1so1402563mue
        for <linux-mips@linux-mips.org>; Wed, 11 Jul 2007 08:07:19 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K9wte67JQWPGLUzRGJp8tgm+E5LXLmFdGHIHQLjSTBqGt3il8QJ9QPv4ReQB1GyLk9h5P8Ylw21AvZB0ignZikcJipn+5z/fu9b1AYDC0U1plDwSKrrBLKp4xoRNOZjUZfALZssGwJNpREOW9E2Uz2tgQ7Rb2Wx1sbjRsConegk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oGLq2k3xmj2n0ywxA8hDYcoLJmRhUX0lLspZtyI3GbCgTtPCaUpAhlIumx57tEaaBItwj3PXf9/XfmuRy326S/36FLrl1qHFXw9Xcnb2od0SFyRzUg9kWUB0QHXh5cYmKVIjfmvQdLauq523jX/DEs3c9YCmAVzu11edYEOEnpA=
Received: by 10.82.183.19 with SMTP id g19mr11023452buf.1184166439092;
        Wed, 11 Jul 2007 08:07:19 -0700 (PDT)
Received: by 10.82.185.8 with HTTP; Wed, 11 Jul 2007 08:07:19 -0700 (PDT)
Message-ID: <40378e40707110807n2cd32c68tdb8604c5d39e72a6@mail.gmail.com>
Date:	Wed, 11 Jul 2007 17:07:19 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	linux-mips@linux-mips.org
Subject: Porting SMP kernel into a dual-core MIPS architecture
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,
Is there any guidelines/tutorial for porting the SMP kernel into a
dual core new architecture based on MIPS32?
AFAIK, in the x86 world we have Intel MPS 1.4 standard. I wonder if
there exists a similar thing for MIPS. In other words, what are the
minimum requirements needed to port the SMP kernel into such an
architecture?

Thanks a lot in advance.

Best Regards,

-- 
Mohamed A. Bamakhrama
