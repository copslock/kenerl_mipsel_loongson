Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 16:05:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57424 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993006AbcGEOE7UtVOl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jul 2016 16:04:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u65E4wao017782;
        Tue, 5 Jul 2016 16:04:58 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u65E4uB0017781;
        Tue, 5 Jul 2016 16:04:56 +0200
Date:   Tue, 5 Jul 2016 16:04:56 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 01/14] MIPS: uasm: Add CFC1/CTC1 instructions
Message-ID: <20160705140456.GM7075@linux-mips.org>
References: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
 <1466699687-24791-2-git-send-email-james.hogan@imgtec.com>
 <1f659139-ff8a-0291-eec3-9279d4ee9d60@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f659139-ff8a-0291-eec3-9279d4ee9d60@redhat.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jul 05, 2016 at 03:56:31PM +0200, Paolo Bonzini wrote:

> On 23/06/2016 18:34, James Hogan wrote:
> > diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> > index ad718debc35a..4731893db3f7 100644
> > --- a/arch/mips/mm/uasm.c
> > +++ b/arch/mips/mm/uasm.c
> > @@ -49,18 +49,18 @@ enum opcode {
> 
> This "enum opcode" looks like a pretty bad conflict magnet.  Ralf, can
> you check if you have any patches affecting it too?

Nothing at this point.

  Ralf
