Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Dec 2010 14:04:35 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:35225 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491173Ab0LLNEc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Dec 2010 14:04:32 +0100
Received: by wyf22 with SMTP id 22so5021707wyf.36
        for <linux-mips@linux-mips.org>; Sun, 12 Dec 2010 05:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=CGOkekYRzU8rSMcVyzD4qicQ4V+UW6oJBOYgDlx1Vfs=;
        b=oMM9tkUGaYLZtKluPa5VGWAhXPx+e7oYfdJDYweCpsiIISrVn28bWd1/sy+VksRAtf
         qIew5Q2U0pyBEbNrpkLgyHXK2CGicyqOQfd4FZo0J3qApeJT2SnLoSxBcw+SnaNBouYv
         GNNgI7nwj85UI6cPcGBtew5O+QGLefqpGilxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=G7IjUIw6pN+7VfFgpw/PWu0H3r2Fbxnt1d/pFjqPDgnU8jwZWHVqFTbRxDov/xP/7/
         VsNc2wTU+2K38GH26gGaEjf+tUsApVGW4ljecBBqmMjTXB+Cn1f17EAJ8Zm9oHyqpGUs
         A+7eBS8ouF1kKjzW3eu2YmycEM58vCduRp6xY=
MIME-Version: 1.0
Received: by 10.216.3.144 with SMTP id 16mr1980023weh.45.1292159066773; Sun,
 12 Dec 2010 05:04:26 -0800 (PST)
Received: by 10.216.157.146 with HTTP; Sun, 12 Dec 2010 05:04:26 -0800 (PST)
Date:   Sun, 12 Dec 2010 18:34:26 +0530
Message-ID: <AANLkTim56SgZLMHySxDNwU3=23+enyv_8StBbKoo8De9@mail.gmail.com>
Subject: Re MIPS-DSP-ASE Instructions
From:   Asutosh Das <das.asutosh@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <das.asutosh@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: das.asutosh@gmail.com
Precedence: bulk
X-list: linux-mips

Hi ,
We are trying to use the MIPS-DSP-ASE instructions to extract bits
from a bit-stream.
The version is MIPS-32 rev 1. (Little Endian) (Linux 2.6.30.9)
The problem is that, the extp and its variants extract the bits from
left-most i.e. MSB.
So each time we have to load to the accumulator, we have to reverse
the stream and then load,
and extract and then reverse. This in-turn is reducing the perfomance
rather than increasing it.

For instance,
Stream -> 111011011
extract 3-bits in C code => 011 (x = (unsigned) stream& ((1<<3 )-1) )
Load this stream to accumulator and extract 3 bits => 111

====
Now reverse the stream and load to accumulator => 110110111
extract 3 bits from accumulator => 110
Now reverse the extracted bits =>011

So we have to reverse the stream before loading to the accumulator and
reverse it again after extracting from
accumulator which reduces the performance drastically.
we guess the MIPS engineers would definitely have thought about it but
we are unable to figure out a way to use these
instructions without reversing the bit-streams.

Please can you let us know a way to use these instructions without reversing.

-- 
Thank you,
Warm Regards,
Asutosh Das
# (91) 9818 4494 69
