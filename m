Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 22:30:34 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:46187 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007274AbbBYVacMhmRZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 22:30:32 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 34DF91538A; Wed, 25 Feb 2015 21:30:26 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     linux-mips@linux-mips.org
Subject: Re: 4.0-rc1 breakage in FPE?
References: <20150225182048.GC31062@paulmartin.codethink.co.uk>
Date:   Wed, 25 Feb 2015 21:30:26 +0000
In-Reply-To: <20150225182048.GC31062@paulmartin.codethink.co.uk> (Paul
        Martin's message of "Wed, 25 Feb 2015 18:20:48 +0000")
Message-ID: <yw1xlhjl7k7h.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Paul Martin <paul.martin@codethink.co.uk> writes:

> Some change between 3.19 and 4.0-rc1 has broken the FPE such that some
> code running on an Octeon II is subtly not working.
>
> eg.
>
>   $ echo "1 2" | gawk '{ print $1 }'
>   1 2
>
> which should output (and does output on 3.19)
>
>   $ echo "1 2" | gawk '{ print $1 }'
>   1
>
> I'm going to try bisecting this over the next few days.
>
> We've been here before...
>
> cf.  http://www.linux-mips.org/archives/linux-mips/2014-07/msg00431.html
>
> -- 
> Paul Martin                                  http://www.codethink.co.uk/
> Senior Software Developer, Codethink Ltd.
>

-- 
Måns Rullgård
mans@mansr.com
