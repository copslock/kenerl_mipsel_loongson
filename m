Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 01:05:59 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.196]:45935 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225264AbVATBFx>;
	Thu, 20 Jan 2005 01:05:53 +0000
Received: by wproxy.gmail.com with SMTP id 70so31671wra
        for <linux-mips@linux-mips.org>; Wed, 19 Jan 2005 17:05:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=nGeZL1NCkkDNYqu2E+HCXLQqgkH62L4akKJZB4Yly+7H0Jvm8UgrC+lUEekgG3XhKlU1c9CVd02d530kRp58bzFOGVJ+LYu2QhCOBJX3WQmQKIORNGv4bNx8pkiespuuCYBzeomLruSgneHyTBw6/+aRwOq2mwM4RpyfGBmU5b0=
Received: by 10.54.13.43 with SMTP id 43mr266137wrm;
        Wed, 19 Jan 2005 17:05:46 -0800 (PST)
Received: by 10.54.41.39 with HTTP; Wed, 19 Jan 2005 17:05:46 -0800 (PST)
Message-ID: <ecb4efd10501191705570371d4@mail.gmail.com>
Date:	Wed, 19 Jan 2005 20:05:46 -0500
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Au1550 crypto engine and linux?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

This may be a bit off topic, but this list seems to be a good place to
try. I was wondering if anyone here is using the Au1550 crypto engine
with linux. I'm working on a device that will have all communications
encrypted with SSL or IPSec. I am looking to use the crypto engine to
accelerate OpenSSL & IPSec and provide a source of quality random
numbers. The DBAu1550 CD came with a Linux CGX driver, but I'm not
sure what that driver actually provides or how it is intended to be
used. The OpenSSL code has for several different hardware crypto
devices, but I didn't see any reference to SafeNet or CGX. It also has
support for /dev/crypto, but that only seems to be implemented for
OpenBSD. Any ideas how this block is supposed to do be used?

                              Thank you,
                              Clem Taylor
