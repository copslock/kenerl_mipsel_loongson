Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 01:01:16 +0200 (CEST)
Received: from nixon.xkey.com ([209.245.148.124]:59267 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S1123254AbSIQXBP>;
	Wed, 18 Sep 2002 01:01:15 +0200
Received: (qmail 24204 invoked from network); 17 Sep 2002 23:01:03 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 17 Sep 2002 23:01:03 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id g8HMws801974
	for linux-mips@linux-mips.org; Tue, 17 Sep 2002 15:58:54 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Tue, 17 Sep 2002 15:58:54 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: [RFC] FPU context switch
Message-ID: <20020917155854.B1883@wumpus.attbi.com>
References: <NEBBLJGMNKKEEMNLHGAIOEAHCJAA.mdharm@momenco.com> <019d01c25e99$d9786af0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <019d01c25e99$d9786af0$10eca8c0@grendel>; from kevink@mips.com on Wed, Sep 18, 2002 at 12:30:23AM +0200
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 18, 2002 at 12:30:23AM +0200, Kevin D. Kissell wrote:

> I'm extremely skeptical about this "evidence".

The only good test is Linux with and without lazy saves. Throwing in a
new OS complicates matters. It sounds like Jun already has working
code for (1) and (3), so he can do a good test.

> Indeed, I could have sworn that someone had already done that the
> last time the topic got thrashed around on this list.

Yes, I remember that too, which is why I'm surprised the issue came up
again.

g
