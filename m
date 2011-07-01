Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2011 17:31:56 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:10333 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491131Ab1GAPbs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Jul 2011 17:31:48 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p61FVQJG017817
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 1 Jul 2011 11:31:26 -0400
Received: from redhat.com ([10.3.112.11])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p61FVJDT013041;
        Fri, 1 Jul 2011 11:31:20 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <s5hiprnwjf4.wl%tiwai@suse.de>
References: <s5hiprnwjf4.wl%tiwai@suse.de> <20110630091754.GA12119@linux-mips.org> <s5h8vsjy68z.wl%tiwai@suse.de> <20110630105254.GA25732@linux-mips.org> <s5h39iry3xp.wl%tiwai@suse.de> <s5hy60jwocc.wl%tiwai@suse.de> <20110630123212.GA6690@linux-mips.org> <s5hoc1fwl37.wl%tiwai@suse.de> <20110630124333.GA9727@linux-mips.org> 
To:     Takashi Iwai <tiwai@suse.de>
Cc:     dhowells@redhat.com, Ralf Baechle <ralf@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        florian@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
        linux-arch@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: SB16 build error.
Date:   Fri, 01 Jul 2011 16:31:18 +0100
Message-ID: <3602.1309534278@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-archive-position: 30577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 739

Takashi Iwai <tiwai@suse.de> wrote:

> OK, here is the patch.

Acked-by: David Howells <dhowells@redhat.com>
