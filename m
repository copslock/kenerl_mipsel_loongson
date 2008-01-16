Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2008 02:54:59 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.180]:52940 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20039730AbYAPCyu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jan 2008 02:54:50 +0000
Received: by py-out-1112.google.com with SMTP id a73so106478pye.22
        for <linux-mips@linux-mips.org>; Tue, 15 Jan 2008 18:54:49 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=mpSWffPSRaSc0yMeAOZushleVxANbho3E8j6HpWaaB0=;
        b=trJHemmWkJWHhaWgiRthyKqmiqDv6qpCCKL5j6kniy+VBnR50ySvRmA6ZQAtJxO9t5xkaOqYacTLULFlyd/XjAa4d7UfRyo5KrYUTDKYUdTE6dxyMWCIgFJ0sz4YQSHimsP8eD4Hex0FsTyDE4qCD1OYsuCKL5ReXENEhJ7CiXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=oqGCiycN9u5cMv31sZLN9YlIJBGQafefmqptnpqqOJbHQ0bTnjxTuAKQrYYXBPx7KCHTUoaX+9DamuIW4sMNklwpPy8kuGBAu+OFcaJkJgN68g58OnE0aQzrghjnvNb+HtRCOrdFsIh4rRmMlUxCB/PeB+e5ESINOfODujwl57I=
Received: by 10.35.69.11 with SMTP id w11mr245932pyk.60.1200452088774;
        Tue, 15 Jan 2008 18:54:48 -0800 (PST)
Received: by 10.35.16.3 with HTTP; Tue, 15 Jan 2008 18:54:48 -0800 (PST)
Message-ID: <50c9a2250801151854i92164c5lcf45fa57d47014dd@mail.gmail.com>
Date:	Wed, 16 Jan 2008 10:54:48 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: does anyone get mpatrol work on linux for mips?
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12289_1728144.1200452088770"
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_12289_1728144.1200452088770
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,all
          because valgrind not support mips now, i try to get mpatrol work
on our board(with linux-2.6.14)
          i download the src, after compile and run a simple test programme
calling MP_MALLOC
          it get a "Segmentation Fault" error.
          then i add some print in the mpatrol lib, found that
         something seemes wrong at calling "__mp_frameinfo" in
mpatrol/src/stack.c
        does anyone run mpatrol success on linux for mips?

        thanks for any hints

Best Regards

zzh

------=_Part_12289_1728144.1200452088770
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,all<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; because valgrind not support mips now, i try to get mpatrol work on our board(with linux-2.6.14)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i download the src, after compile and run a simple test programme&nbsp; calling MP_MALLOC<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; it get a &quot;Segmentation Fault&quot; error.
<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; then i add some print in the mpatrol lib, found that<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; something seemes wrong at calling &quot;__mp_frameinfo&quot; in mpatrol/src/stack.c<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; does anyone run mpatrol success on linux for mips?
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thanks for any hints<br><br>Best Regards<br><br>zzh<br>

------=_Part_12289_1728144.1200452088770--
