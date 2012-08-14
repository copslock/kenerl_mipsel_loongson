Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 16:08:29 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:60311 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903847Ab2HNOIY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 16:08:24 +0200
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7EE8FUf012863
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 14 Aug 2012 10:08:16 -0400
Received: from warthog.procyon.org.uk ([10.3.112.16])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7EE8Bin000825;
        Tue, 14 Aug 2012 10:08:12 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87d32us55c.fsf@rustcorp.com.au>
References: <87d32us55c.fsf@rustcorp.com.au> <1344332473-19842-1-git-send-email-jonas.gorski@gmail.com> <31154.1344872382@warthog.procyon.org.uk>
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     dhowells@redhat.com, Jonas Gorski <jonas.gorski@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: fix module.c build for 32 bit
Date:   Tue, 14 Aug 2012 15:08:10 +0100
Message-ID: <32504.1344953290@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
X-archive-position: 34157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Rusty Russell <rusty@rustcorp.com.au> wrote:

> Yep, thanks.  And might as well sent them straight to Linus; since
> linux-next didn't catch this, there's little point baking them there if
> we have some acks.
> 
> If he misses it, I'll grab them.

It might have to wait for the next merge window.

David
