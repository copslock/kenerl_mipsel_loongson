Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 10:50:01 +0000 (GMT)
Received: from jaguar.mkp.net ([IPv6:::ffff:192.139.46.146]:58345 "EHLO
	jaguar.mkp.net") by linux-mips.org with ESMTP id <S8224914AbUA1KuA>;
	Wed, 28 Jan 2004 10:50:00 +0000
Received: from jes by jaguar.mkp.net with local (Exim 3.35 #1)
	id 1AlnGh-0005Ko-00; Wed, 28 Jan 2004 05:49:59 -0500
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Kevin Paul Herbert <kph@cisco.com>, linux-mips@linux-mips.org
Subject: Re: Removal of ____raw_readq() and ____raw_writeq() from asm-mips/io.h
References: <1075255111.8744.4.camel@shakedown>
	<20040128094032.GB900@kopretinka>
From: Jes Sorensen <jes@wildopensource.com>
Date: 28 Jan 2004 05:49:58 -0500
In-Reply-To: <20040128094032.GB900@kopretinka>
Message-ID: <yq07jzcz6sp.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jes@trained-monkey.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jes@wildopensource.com
Precedence: bulk
X-list: linux-mips

>>>>> "Ladislav" == Ladislav Michl <ladis@linux-mips.org> writes:

Ladislav> On Tue, Jan 27, 2004 at 05:58:31PM -0800, Kevin Paul Herbert
Ladislav> wrote:
>> In edit 1.68, the non-interrupt locking versions of
>> raw_readq()/raw_writeq() were removed, in favor of locking
>> ones. While this makes sense in general, it breaks the compilation
>> of the sb1250 which uses the non-locking versions (____raw_readq()
>> and ____raw_writeq()) in interrupt handlers.

Ladislav> Why was someone using these function at all? if you don't
Ladislav> need locking simply do *reg_addr = val;

ARGHHHHHHHHHH!

If you are accessing memory mapped registers or memory on a PCI
device, ie. likely on a 1250, you *must* use the readX/__raw_readX
macros. Anybody just doing *reg = val on a PCI device should be
banned from writing code for life!

Jes
