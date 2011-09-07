Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2011 11:26:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37912 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491189Ab1IGJ0Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Sep 2011 11:26:16 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p879O1lJ027420;
        Wed, 7 Sep 2011 11:24:01 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p879M7WE027357;
        Wed, 7 Sep 2011 11:22:07 +0200
Date:   Wed, 7 Sep 2011 11:22:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yong Zhang <yong.zhang0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        John Stultz <johnstul@us.ibm.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        David Howells <dhowells@redhat.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Frysinger <vapier@gentoo.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Arun Sharma <asharma@fb.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Anoop P A <anoop.pa@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Kosina <jkosina@suse.cz>,
        "Justin P. Mattock" <justinmattock@gmail.com>,
        Joe Perches <joe@perches.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 14/62] MIPS: irq: Remove IRQF_DISABLED
Message-ID: <20110907092207.GA25833@linux-mips.org>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
 <1315383059-3673-15-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1315383059-3673-15-git-send-email-yong.zhang0@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3721

On Wed, Sep 07, 2011 at 04:10:11PM +0800, Yong Zhang wrote:

> This flag is a NOOP and can be removed now.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
