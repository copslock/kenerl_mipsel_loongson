Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 13:12:30 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42288 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903802Ab1KPMMX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 13:12:23 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAGCCAr3005490;
        Wed, 16 Nov 2011 12:12:10 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAGCC775005481;
        Wed, 16 Nov 2011 12:12:07 GMT
Date:   Wed, 16 Nov 2011 12:12:07 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Victor Kamensky <kamensky@cisco.com>
Cc:     David Daney <david.daney@cavium.com>,
        "manesoni@cisco.com" <manesoni@cisco.com>,
        "ananth@in.ibm.com" <ananth@in.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/4] MIPS Kprobes: Deny probes on ll/sc instructions
Message-ID: <20111116121207.GA5079@linux-mips.org>
References: <20111108170336.GA16526@cisco.com>
 <20111108170535.GC16526@cisco.com>
 <4EB98A8E.4060900@cavium.com>
 <Pine.GSO.4.58.1111081504560.10959@infra-view9.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.1111081504560.10959@infra-view9.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13347

On Tue, Nov 08, 2011 at 03:26:42PM -0800, Victor Kamensky wrote:

> > s/insturctions/instructions/
> >
> > Not only is it a bad idea, it will probably make them fail 100% of the time.
> >
> > It is also an equally bad idea to place a probe between any LL and SC
> > instructions.  How do you prevent that?
> 
> As per below code comment we don't prevent that. There is no way to do
> that.

Similar to the way that the addresses of loads and stores from userspace
are recorded in a special section we could build a list of forbidden
address range.

Is it worth it?

  Ralf
