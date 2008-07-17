Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2008 20:59:54 +0100 (BST)
Received: from qw-out-1920.google.com ([74.125.92.147]:37396 "EHLO
	qw-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S28586273AbYGQT7r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 Jul 2008 20:59:47 +0100
Received: by qw-out-1920.google.com with SMTP id 5so63574qwf.54
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2008 12:59:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=YwudQatPv9u5NjtbpfehfazWW+rgnvHHNSKNzX4hP10=;
        b=oHqIh/9o99Sd21B/5EcVQCe+memTk47mXwY2Sb+Tnmo7hrR8RzsRh7hlqE58UgQNYp
         MHmbaOrEeLNvczNrveq8JN0v4S0qWaUHuJJepqQUAlkTToLNlEWV0ggFg9qAH5VTpCYr
         U0Z6fCVrzkQ5mgC3vSir1Nhwxn3pHT5qbYUP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Pmkmg32eySlACHBS8HcYd2g2SvqLgvhwpoSBp0lWuuBdvwMtuulvAu+Qs2mqRCCQ3L
         o7p0jegxTA8jcjTN66zzkEqBVt3VFpl7jns7VLIL8CW59EJIr7BMc3/Wgwwh5Jwf9Fya
         0T+oj/1BqON71JXBXlzGYmZd5pDEYNSpRPNU8=
Received: by 10.142.174.18 with SMTP id w18mr783059wfe.290.1216324785504;
        Thu, 17 Jul 2008 12:59:45 -0700 (PDT)
Received: by 10.142.49.17 with HTTP; Thu, 17 Jul 2008 12:59:45 -0700 (PDT)
Message-ID: <64660ef00807171259l55f85380l47cfdc7574f84099@mail.gmail.com>
Date:	Thu, 17 Jul 2008 20:59:45 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: HOWTO submit patches using WebMail - Help appreciated?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 3a0088870239d4b8
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

All,

I am having issues getting patches to the mailing list in a format
that seems to be acceptable.
I have done all I can to the patch itself but I am having mail client
issues as well.
I have tried Gmail with plaintext.
I have also tried Lotus Notes and Nabble however they all seem to get
in the way of submitting a good patch.

Is there anyone who has used a web mail client and had success, most
details out there are for Evolution / Thunderbird users not from
people with Work based mail accounts.

Any help appreciated as I am about to re submit PNX833X patches and
would like to get it right :-)
Cheers
Dan
