Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 15:09:46 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007221AbbE0NJpJWE0z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 15:09:45 +0200
Date:   Wed, 27 May 2015 14:09:45 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 01/10] MIPS: Add SysRq operation to dump TLBs on
 all CPUs
In-Reply-To: <alpine.LFD.2.11.1505261230020.11225@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1505271407470.21603@eddie.linux-mips.org>
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com> <1432025438-26431-2-git-send-email-james.hogan@imgtec.com> <556240DE.1050003@gentoo.org> <alpine.LFD.2.11.1505261230020.11225@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 26 May 2015, Maciej W. Rozycki wrote:

>  James, I think what you proposed is good enough for TLB diagnostics (I'm 
> not sure if dumping EntryLo0 and EntryLo1 registers has any use, but it 
> surely does not hurt either).

 And BTW, please update Documentation/sysrq.txt accordingly!

  Maciej
