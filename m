Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2010 09:05:16 +0100 (CET)
Received: from mail-fx0-f216.google.com ([209.85.220.216]:57434 "EHLO
        mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491885Ab0BEIFN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2010 09:05:13 +0100
Received: by fxm8 with SMTP id 8so1986552fxm.26
        for <linux-mips@linux-mips.org>; Fri, 05 Feb 2010 00:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=BQVG624v9Cm8y5VEcn3X0UsjtJAUlHG7BpApqSatp8g=;
        b=MfVXz2ijLCfnhLZ4bn21Y0AWHgCtZrBsFwNlid6/r2GXGeix8LAP/8nIUx7MfxI/9T
         /2tGiURRZw+l0cZ6j4Qsr7Ty54Tv0traRceJlZA/fEG13xNQRcjRGXM+fpmrP6dy4ohp
         TzrffPP9Hkslyyaz8uI5yDWKrLt+XViNMQDCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=gWWcrqwfOqvtMBNLkwY0LxWBywI3eX5AMYD7Wx+Y+BIH/rbKPh0P+LzAuj6KFgneIg
         TGN2yxStWDzmLf4/38tTTxxt+TIZcGnYEN+YfmYZixwsergV246nRhpX+PFDPmEIqdOp
         zptZ413FsvkZ17IMewlSIYhh0y9xW37ko0y+0=
MIME-Version: 1.0
Received: by 10.223.6.70 with SMTP id 6mr1960818fay.29.1265357107235; Fri, 05 
        Feb 2010 00:05:07 -0800 (PST)
Date:   Fri, 5 Feb 2010 08:05:07 +0000
Message-ID: <4101f55c1002050005t1d7e1b09qe988e39932dfc411@mail.gmail.com>
Subject: Switch FPU emulator trap to BREAK instruction
From:   Muthu Kumaran <muthukumaranbe@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <muthukumaranbe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muthukumaranbe@gmail.com
Precedence: bulk
X-list: linux-mips

I am using 2.6.18 linux version on MIPS32 core. One of the application
is using intensive floating point operations. This hardware doesn't
have FPU and also the application is not compiled for software
floating point support.
Hence, it is using the floating point emulation.

While running that application, On a timer interrupt there is a normal
integer div instruction which gives wrong result in the HI register.

However, when I applied the following patch, this problem disappeared.

http://kerneltrap.org/mailarchive/git-commits-head/2008/10/30/3873324

When I looked into the patch, handling of invalid instruction
exception is moved from trap to break.
There is no other behavioural change in this patch. I really don't
understand the need for this patch, May I ask someone to explain the
background information behind this patch? Is this for any known issue?

Thanks.
I am new to both Linux and also MIPS core.

-- 
http://testbed.aws.cit.ie/panneer
