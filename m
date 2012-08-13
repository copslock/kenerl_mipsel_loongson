Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2012 17:40:04 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:65523 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903549Ab2HMPj5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Aug 2012 17:39:57 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7DFdmle008239
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 13 Aug 2012 11:39:49 -0400
Received: from warthog.procyon.org.uk ([10.3.112.16])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7DFdhwN012586;
        Mon, 13 Aug 2012 11:39:44 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1344332473-19842-1-git-send-email-jonas.gorski@gmail.com>
References: <1344332473-19842-1-git-send-email-jonas.gorski@gmail.com>
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     dhowells@redhat.com, Jonas Gorski <jonas.gorski@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: fix module.c build for 32 bit
Date:   Mon, 13 Aug 2012 16:39:42 +0100
Message-ID: <31154.1344872382@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-archive-position: 34127
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


Hi Rusty,

I've fixed up my patch for ARM and pulled Jonas's patch on top of that.  Do
you want me to merge them together?

David
