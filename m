Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 14:05:50 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:64701 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133570AbWAYOFc
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 14:05:32 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0PE9fJS013977;
	Wed, 25 Jan 2006 06:09:42 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k0PE9fYr022497;
	Wed, 25 Jan 2006 06:09:41 -0800 (PST)
Message-ID: <43D78725.6050300@mips.com>
Date:	Wed, 25 Jan 2006 15:11:49 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>	 <20060125124738.GA3454@linux-mips.org> <cda58cb80601250534r5f464fd1v@mail.gmail.com>
In-Reply-To: <cda58cb80601250534r5f464fd1v@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Franck wrote:
> Hi Ralf
> 
> 2006/1/25, Ralf Baechle <ralf@linux-mips.org>:
>> On Wed, Jan 25, 2006 at 10:36:46AM +0100, Franck wrote:
>>
>>> Here is a little patch to optimize swab operations by using "wsbh"
>>> instruction available on mips revision 2 cpus. I do not know what
>>> condition I should use to compile this only for mips r2 cpu though.
>>>
>>> Comments ?
>> Looks good aside of the one issue you've already raised yourself:
>>
>>> +/* FIXME: MIPS_R2 only */
> 
> I was actually asking for advices :)
> 
> I can see only two simple ways to do that:
> (a) we can define a couple of new macro ie CONFIG_MIPS32_ISET_R[12]
> that can be set depending on the selected CPU;
> (b) define a new macro CONFIG_CPU_HAS_WSBH;

Don't we already have CONFIG_CPU_MIPS32R2?
