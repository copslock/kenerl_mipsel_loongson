Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 04:00:00 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:47893 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492134AbZKRC7x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2009 03:59:53 +0100
Received: by pwi15 with SMTP id 15so422409pwi.24
        for <linux-mips@linux-mips.org>; Tue, 17 Nov 2009 18:59:44 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=bMytSMvCfw07TJ7DbLbr07s9cEkwqrfxAKyE6be6ab4=;
        b=YqZiHc+FU4rtPuQ1ax+bkqB9+QaOUl5idfKyWCfpeb8sfCYLFuRzArXjuW0ZaczJsl
         aC3pbK9XzAJF64trsDn9IIaNeAigi2ZLjv7iwwvrFcqYTQwwwjgVMC9Mt5C2AQWcOfIK
         kP4ortWz35pdLUag2WxZLHI8tCh3n1s5iEjk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vq513pEVUJW0wIcOizp4AgcEVBc8x6Vm0y7lGm8Hrd3GBSouLe/K8mIjWLVhLLQ7hX
         mCbNr+/DU7nMiHDJEAxj3KbJhSwfGeOjWJAX7srOhc/WMgBlJIXf9sbUYYabICn55Q16
         fnF+/NzDttI/FKkiaEWZKfvNqa+uJZFkpQMxU=
MIME-Version: 1.0
Received: by 10.114.18.17 with SMTP id 17mr12288963war.131.1258513183644; Tue, 
	17 Nov 2009 18:59:43 -0800 (PST)
Date:	Wed, 18 Nov 2009 10:59:43 +0800
Message-ID: <c6ed1ac50911171859k24685b32m237afd68f63c626f@mail.gmail.com>
Subject: how i can know the linux-mips implememt cache strategy?
From:	figo zhang <figo1802@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00163692089b419d1c04789c6f91
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

--00163692089b419d1c04789c6f91
Content-Type: text/plain; charset=ISO-8859-1

hi all,

I am porting 24KEC soc to linux new, i have see the mips-kernel impement
cache strategy: invalid and write-back,
is it right?  is it implement the write-through strategy? see in
include/asm-mips/r4kcache.h

how i can know the kernel using which cache strategy in user space, such
as how can see the /proc system to know it?

Best,
Figo.zhang

--00163692089b419d1c04789c6f91
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>hi all,</div>
<div>=A0</div>
<div>I am porting 24KEC soc to linux new, i have see the mips-kernel impeme=
nt cache strategy: invalid and write-back,</div>
<div>is it right?=A0 is it implement the write-through strategy? see in inc=
lude/asm-mips/r4kcache.h</div>
<div>=A0</div>
<div>how i can know the kernel using which cache strategy in user space, su=
ch as=A0how can see the /proc system to know it?</div>
<div>=A0</div>
<div>Best,</div>
<div>Figo.zhang</div>

--00163692089b419d1c04789c6f91--
