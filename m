Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Sep 2010 11:16:47 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:44786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491095Ab0INJQn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Sep 2010 11:16:43 +0200
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o8E9FElb031305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 14 Sep 2010 05:15:14 -0400
Received: from redhat.com ([10.3.112.2])
        by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o8E9EjUt018637;
        Tue, 14 Sep 2010 05:14:46 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <cover.1284406638.git.joe@perches.com>
References: <cover.1284406638.git.joe@perches.com>
To:     Joe Perches <joe@perches.com>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        Amit Kumar Salecha <amit.salecha@qlogic.com>,
        linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
        James Smart <james.smart@emulex.com>,
        linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
        PJ Waskiewicz <peter.p.waskiewicz.jr@intel.com>,
        Shreyas Bhatewara <sbhatewara@vmware.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "James E.J. Bottomley" <James.Bottomley@suse.de>,
        Paul Mackerras <paulus@samba.org>, linux-i2c@vger.kernel.org,
        Brett Rudley <brudley@broadcom.com>,
        sparclinux@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-scsi@vger.kernel.org,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        e1000-devel@lists.sourceforge.net,
        Trond Myklebust <Trond.Myklebust@netapp.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Neil Brown <neilb@suse.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        linux-wireless@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        linux-usb@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Alex Duyck <alexander.h.duyck@intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Henry Ptasinski <henryp@broadcom.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
        mjpeg-users@lists.sourceforge.net,
        "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
        linux-nfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neela Syam Kolli <megaraidlinux@lsi.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Linus Walleij <linus.walleij@stericsson.com>,
        netdev@vger.kernel.org,
        Anirban Chakraborty <anirban.chakraborty@qlogic.com>,
        Bruce Allan <bruce.w.allan@intel.com>
Date:   Tue, 14 Sep 2010 10:14:45 +0100
Message-ID: <28081.1284455685@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
X-archive-position: 27752
Subject: (no subject)
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10737

Joe Perches <joe@perches.com> wrote:

> Using static const char foo[] = "bar" can save some
> code and text space, so change the places where it's possible.

That's reasonable.

> Also change the places that use
> 	char foo[] = "barX";
> 	...
> 	foo[3] = value + '0';
> where X is typically changed
> 	char foo[sizeof("barX")];
> 	...
> 	sprintf(foo, "bar%c", value + '0');

You haven't said what this gains.  I can see what it may cost, though
(depending on how gcc loads foo[]).

David
