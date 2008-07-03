Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 15:51:05 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.174]:28023 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20130425AbYGCOun (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Jul 2008 15:50:43 +0100
Received: by wf-out-1314.google.com with SMTP id 27so926140wfd.21
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2008 07:50:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ViDqCdSNz8P/ZSF6nlyJcQhxX3DrOPn2e/3PAJam2UE=;
        b=WHyWYo2Yw1i/93gvNqEbxSX2Ew9y6KRPVAr6E5vYRtzHcSkOzN9hm8/G0HrNA80uHh
         4XzfHOEL4zzK0cmL0HO5wRnXIi+97fGAYQrDZkn1ZsCr/xz4znCCMAxMigHZV0mo91/0
         pv4p1nU3Jtsr3fPLxGMoOnMQiyBE8jhyzlLWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ehu0ygmRhaUG83iYnqboql1eJVp1TFfD4UpvW7MhKxUupuXx0r7LJsDu21lC+85CtN
         YW07pMo0w1UOorbWGlgfNLNmpY2KKp1u2mdGxIeZvVLdUpVqkVxRdRiiYnq+4kYWWhqy
         VPyNOTouAl7+eJWBD3ogLbP6ZR1lDtEi5SCz0=
Received: by 10.142.70.11 with SMTP id s11mr19021wfa.293.1215096640239;
        Thu, 03 Jul 2008 07:50:40 -0700 (PDT)
Received: by 10.142.204.16 with HTTP; Thu, 3 Jul 2008 07:50:40 -0700 (PDT)
Message-ID: <19f34abd0807030750n31a3bc3t8609f58c9c1f7c7@mail.gmail.com>
Date:	Thu, 3 Jul 2008 16:50:40 +0200
From:	"Vegard Nossum" <vegard.nossum@gmail.com>
To:	saravanakumar <saravanakumar.s@teclever.com>
Subject: Re: kernel configuration_ help
Cc:	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <1214997772.16081.3.camel@teclever-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1214997772.16081.3.camel@teclever-desktop>
Return-Path: <vegard.nossum@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vegard.nossum@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Jul 2, 2008 at 1:22 PM, saravanakumar
<saravanakumar.s@teclever.com> wrote:
> hai,
> i want my usb to access the root file system,for that what are the
> changes to be done in kernel code, and  in the configuration, i think
> changes to be done in do_mount.c for root delay, if its correct where to
> give the delay.

Hi,

If I understand correctly, you have your root filesystem on a USB
device. It seems that you must pass the rootdelay= option on the
kernel command line. No changes to the code should be necessary.

From Documentation/kernel-parameters.txt:

        rootdelay=      [KNL] Delay (in seconds) to pause before attempting to
                        mount the root filesystem

Try 10 seconds first, then go lower until it stops working.

It seems that this unfortunate hack is necessary because USB devices
can take an indefinite amount of time to register themselves once
connected.

You will of course also need the relevant config options. Make sure
your filesystem is selected, Advanced partition selection, USB, and
SCSI disk support.

Good luck!


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
