Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 09:46:11 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.236]:16487 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8133484AbWGaIqB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Jul 2006 09:46:01 +0100
Received: by wr-out-0506.google.com with SMTP id i31so348156wra
        for <linux-mips@linux-mips.org>; Mon, 31 Jul 2006 01:46:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=daOpDG9BhJG0UqNg3r/CSCUkPWDCIAIbtCnRlcPsriqy2Pkh5KGQq1+/WuSOIEJ0B0GhFopWJqFlkMvwYeZQzSBqjt3DkOoDq8Eai16wyBvGjPQzbyA1ONRZ1YAEz/NHdsYJ94flH8pyuEk9Ho4ND0bNLEPXT7bKbcVg9zRdSdA=
Received: by 10.54.152.12 with SMTP id z12mr2183732wrd;
        Mon, 31 Jul 2006 01:46:00 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 38sm4616786wrl.2006.07.31.01.45.57;
        Mon, 31 Jul 2006 01:45:59 -0700 (PDT)
Message-ID: <44CDC30D.2070705@innova-card.com>
Date:	Mon, 31 Jul 2006 10:45:01 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
References: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>	<44C8CEA4.20000@innova-card.com>	<cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com> <20060729.004442.96686266.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060729.004442.96686266.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Hi, Franck.  Thank you for detailed review.
> 
> On Thu, 27 Jul 2006 16:33:08 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> +	unsigned long *stack = (long *)regs->regs[29];
>> why not calling that "sp" ?
> 
> Just because show_trace() named it "stack" :-)
> 

nothing is too late ;)

		Franck
