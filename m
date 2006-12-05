Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 16:49:30 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.186]:36568 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039036AbWLEQtZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Dec 2006 16:49:25 +0000
Received: by nf-out-0910.google.com with SMTP id l24so254514nfc
        for <linux-mips@linux-mips.org>; Tue, 05 Dec 2006 08:49:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=MHjwOS5xmx0+2Q5BiLQJ4/3WyHCpCtblsgWp7kEQLXUVXthKenvQGr1iAPWI3h29FIeiI0QO9vpgEeonQ+pnukzWAsZECX5C7aaenSEyQP5VMWwvQPlJvt6DanTDE/ScPAdC77pdSLqqLhGvidnzoueU7t8M+V2x9yP4+VqD3OI=
Received: by 10.49.92.18 with SMTP id u18mr1088153nfl.1165337364565;
        Tue, 05 Dec 2006 08:49:24 -0800 (PST)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id p43sm3280147nfa.2006.12.05.08.49.22;
        Tue, 05 Dec 2006 08:49:23 -0800 (PST)
Message-ID: <4575A364.1010703@innova-card.com>
Date:	Tue, 05 Dec 2006 17:50:44 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
References: <20061206.012311.86891097.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061206.012311.86891097.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Atsushi Nemoto wrote:
> Import many updates from i386's i8259.c, especially genirq
> transitions.
> 

Does your patch make the following patch out of date (I sent
it to the list 4 days ago) ?

[PATCH] Compile __do_IRQ() when really needed [take #3]

		Franck
