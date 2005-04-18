Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 22:20:54 +0100 (BST)
Received: from sccrmhc14.comcast.net ([IPv6:::ffff:204.127.202.59]:58314 "EHLO
	sccrmhc14.comcast.net") by linux-mips.org with ESMTP
	id <S8225745AbVDRVUi>; Mon, 18 Apr 2005 22:20:38 +0100
Received: from gw.junsun.net (c-24-6-106-170.hsd1.ca.comcast.net[24.6.106.170])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005041821202601400h3dnpe>; Mon, 18 Apr 2005 21:20:26 +0000
Received: from gw.junsun.net (gw.junsun.net [127.0.0.1])
	by gw.junsun.net (8.13.1/8.13.1) with ESMTP id j3ILKNWm013009;
	Mon, 18 Apr 2005 14:20:23 -0700
Received: (from jsun@localhost)
	by gw.junsun.net (8.13.1/8.13.1/Submit) id j3ILKLII013008;
	Mon, 18 Apr 2005 14:20:21 -0700
Date:	Mon, 18 Apr 2005 14:20:21 -0700
From:	Jun Sun <jsun@junsun.net>
To:	Pavel Kiryukhin <vksavl@cityline.ru>
Cc:	linux-mips@linux-mips.org, Manish Lachwani <mlachwani@mvista.com>
Subject: Re: Preemption in do_cpu      (Re: [PATCH]Preemption patch for 2.6)
Message-ID: <20050418212021.GA12996@gw.junsun.net>
References: <1098468403.4266.42.camel@prometheus.mvista.com> <1807918959.20050418133246@cityline.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1807918959.20050418133246@cityline.ru>
User-Agent: Mutt/1.4.1i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips

On Mon, Apr 18, 2005 at 01:32:46PM +0400, Pavel Kiryukhin wrote:
> Hi,
> the preempt_disable/preempt_enable sequence in do_cpu() [traps.c]
> exists quite long (patch submitted in Oct. 2004), so it should be nothing
> wrong there.
> 
> Can somebody please comment why use of preempt_disable/enable in do_cpu
> will not result in "scheduling while atomic" for fpu-less cpu (with enabled
> preemption).
> 
> The sequence looks like
> 
> do_cpu()
> | preempt_disable()
> | fpu_emulator_cop1Handler()
> | | cond_reshed()
> | | | schedule()  <------ scheduling while atomic
> 
> 
> The proposed patch was tested for Sibyte, but it has fpu (AFAIK) and has no
> fpu_emulator_cop1Handler called.
>

fpu_emulator maintains global variables and in general is dangerous
to be preempted in the middle of processing.

The quick fix for this problem is probably to move preemption disabling/
enabling inside fpu_emulator_cop1Handler().

Better fix is probably to modify fpu emulator so that it is preemption
safe overall.

Jun
