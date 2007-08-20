Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2007 09:15:47 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.184]:57505 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021603AbXHTIPo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Aug 2007 09:15:44 +0100
Received: by fk-out-0910.google.com with SMTP id f40so1184102fka
        for <linux-mips@linux-mips.org>; Mon, 20 Aug 2007 01:15:26 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AuHmQ0xIgC0mMSy+EwOmaW8Hdul9ZxRye0bGNUKZLOkwfwfyTTWxsOcXViUIAEDogLMAwzWZ91tKpQ468sKHRDmXz67ZPcujU9CJZwA89EncPXf+Im632ya9wZzQFJDoAD1GBGB7uHiXF2+KccxLrkj3Iyupq0pUkGOmBIl2Yns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qbrjC8I3Tnj7DyenirrnAlmtHm3mvuqNZFSvUDzNl+55pazgMTIsVmRwBb/AGhhSzf8gLFYGB7yu1eKwi55etUovJ9/hXMJcrJL/mamkP276fuYXy3zd87upRy13jETulOK+Kw3mDjGp9IPyDn6n+UdzRLVZOJ4A1HLRonEGGps=
Received: by 10.82.190.2 with SMTP id n2mr7183399buf.1187597725963;
        Mon, 20 Aug 2007 01:15:25 -0700 (PDT)
Received: by 10.82.162.16 with HTTP; Mon, 20 Aug 2007 01:15:25 -0700 (PDT)
Message-ID: <40378e40708200115n2f917dd7tc76ff775f7a2e270@mail.gmail.com>
Date:	Mon, 20 Aug 2007 10:15:25 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	linux-mips@linux-mips.org
Subject: Index Store Tag and Fetch&Lock in MIPS32 24KEc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,
I have playing around with a Malta board which has a MIPS32 24KEc core
(PR.ID = 2.0.1).
I was testing the CACHE instruction and I observed the following
*weird* behavior:
I try to lock a given range of addresses within the cache. I tried to
do so with both operations (i.e. Index store tag and Fetch&Lock). What
I observe is that the Fetch&Lock is locking much *less* lines than
what the index store tag does. Is there anyone who is aware of any
constrains/errata regarding this issue?


Best regards,

-- 
Mohamed A. Bamakhrama
Am Schaeferanger 15, room 035
85764 Oberschleissheim, Germany
Email: bamakhra@cs.tum.edu
Web: http://home.cs.tum.edu/~bamakhra/
Mobile: +49-160-9349-2711
