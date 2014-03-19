Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2014 00:02:33 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:51265 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6842534AbaCSXCarJmNS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Mar 2014 00:02:30 +0100
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2JN2QeB006223
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 19 Mar 2014 19:02:26 -0400
Received: from [10.10.53.247] (vpn-53-247.rdu2.redhat.com [10.10.53.247])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s2JN2OFW006594;
        Wed, 19 Mar 2014 19:02:25 -0400
Message-ID: <1395270144.10106.0.camel@localhost>
Subject: Re: [PATCH 3/4] ARCH: AUDIT: implement syscall_get_arch for all
 arches
From:   Eric Paris <eparis@redhat.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-audit@redhat.com, linux-ia64@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux@openrisc.net,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Date:   Wed, 19 Mar 2014 19:02:24 -0400
In-Reply-To: <CAEdQ38Ex47GxhN1ZZMu+RETpWs-ENbfCr8v=6iFg9p_QWaa9zw@mail.gmail.com>
References: <1395266643-3139-1-git-send-email-eparis@redhat.com>
         <1395266643-3139-3-git-send-email-eparis@redhat.com>
         <CAEdQ38Ex47GxhN1ZZMu+RETpWs-ENbfCr8v=6iFg9p_QWaa9zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <eparis@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eparis@redhat.com
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

On Wed, 2014-03-19 at 15:19 -0700, Matt Turner wrote:
> On Wed, Mar 19, 2014 at 3:04 PM, Eric Paris <eparis@redhat.com> wrote:
> > For all arches which support audit implement syscall_get_arch()
> 
> support audit -- is that AUDIT_ARCH? If so, alpha gained support
> recently, so I think this patch needs to handle alpha too?

Absolutely right.  I broke Alpha (in the next patch).  Will fix.

-Eric
