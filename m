Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 09:45:03 +0100 (BST)
Received: from mail-gx0-f157.google.com ([209.85.217.157]:34519 "EHLO
	mail-gx0-f157.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025285AbZD1Io4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 09:44:56 +0100
Received: by gxk1 with SMTP id 1so884829gxk.0
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2009 01:44:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=xVVutRH4zWc3P2frasQeigzB7OHzP7bICgvpmFDRqSI=;
        b=DMFJAMv4RxoonpbtDzU+aaZAIuK1jQ5c8sjx+CJ+bloxz5aNhGLsAsn4hyGbI91t/i
         z/giJtOZsl0Q36v78C+nkm2wHzkay4BAZUs4hTaRuyBe/bNRHJRVFjKa8t8/oozRDBao
         dV8GCNuNl4zp8S6HmnWvlhzynttZH2fpVsp08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=EfRg8v4DBO34HNQQHfKJzZvc5dtBG6NWn8UnplOmY6+lfqmJVSIivFvfS3J2qggWe3
         ll/+9eE7KuFwx8TT8lC+5UBHIB+VkBD1MMXebVYOc5jNXwm8boQy4Em1rFGjxe/6A40w
         dnsArGmwj96aOspZiFPIGpW7qWXEuDYsiNLAU=
MIME-Version: 1.0
Received: by 10.151.137.5 with SMTP id p5mr10610675ybn.155.1240908289870; Tue, 
	28 Apr 2009 01:44:49 -0700 (PDT)
Date:	Tue, 28 Apr 2009 16:44:49 +0800
Message-ID: <777f39b10904280144n40637597tf5d7da2a6c337d11@mail.gmail.com>
Subject: [mips simulator help] I want to use simulator to run 2.4.21 kernel 
	(mips ->malta board) .
From:	Bob Zhang <2004.zhang@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	"bob.zhang2004" <bob.zhang2004@gmail.com>,
	"Christophe.Carvounas" <christophe.carvounas@gmail.com>,
	Bob Zhang <2004.zhang@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <2004.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 2004.zhang@gmail.com
Precedence: bulk
X-list: linux-mips

1,
now , I know " gxemul " should act as this task .

but , from gxemul website , I can't get detailed information,
for example, for simulator , how to compile our linux kernel source
code, they only provide their vmlinux binary, but this is useless for
developers.  we don't want a existed vmlinux,  we need to recompile
linux kernel code to run and we can modify our own kernel source code
to develop linux kernel.


Could you tell me how to build up a environment to use gxeuml to run
2.4.21 or 2.4.x (mips ->malta board) , any comment is welcome.
thanks very much!

I have experience to play , skyeye , but skyeye seems that doesn't
support MIPS yet(from the news from their offical website) .

except for skyeye and gxemul , what simulators can run 2.4.x mips kernel ?

2, which mipsel toolchain can be suitable for compiling 2.4.21 mips
malta board code ?
thanks for the url , thanks very much!
