Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 09:17:32 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.194]:6416 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133420AbWG1IRX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Jul 2006 09:17:23 +0100
Received: by nz-out-0102.google.com with SMTP id q3so137946nzb
        for <linux-mips@linux-mips.org>; Fri, 28 Jul 2006 01:17:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=gtOkU+uTCRT5nvgVDv8kr5wMPFek7C9JiGecIbDclojplooE55nIy3rPI+6yOdEj0VYWnyptN42qbsClKF5s1WBFOHYid1+Z/R67FD1sNVU0+dk6/Y2PlP279mdsmeSSyJE4iIxk9qLmCTz/acA/Wdm0Wb0rnHaLBqNTlR+7Vic=
Received: by 10.65.112.5 with SMTP id p5mr2151640qbm;
        Fri, 28 Jul 2006 01:17:21 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 22sm684724nzn.2006.07.28.01.17.19;
        Fri, 28 Jul 2006 01:17:21 -0700 (PDT)
Message-ID: <44C9C7D2.3000207@innova-card.com>
Date:	Fri, 28 Jul 2006 10:16:18 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
References: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>	 <44C8CEA4.20000@innova-card.com> <cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com>
In-Reply-To: <cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> one more comment,
> 

argh, your patch is already applied ! No room for comments
on MIPS...BTW, are these patches going to be included in
a 2.6.18-rcX release ?

Anyways, I'll send to you a patch on top of yours including
my changes if you agree with them.

Thanks
		Franck
