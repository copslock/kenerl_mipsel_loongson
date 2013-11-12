Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2013 16:55:54 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:2999 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867663Ab3KLPzl1JLmV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Nov 2013 16:55:41 +0100
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rACFtEnE020673
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 12 Nov 2013 10:55:14 -0500
Received: from [10.3.113.54] (ovpn-113-54.phx2.redhat.com [10.3.113.54])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id rACFtCAE023159;
        Tue, 12 Nov 2013 10:55:12 -0500
Message-ID: <1384271711.24631.5.camel@deneb.redhat.com>
Subject: Re: [PATCH 00/11] Consolidate asm/fixmap.h files
From:   Mark Salter <msalter@redhat.com>
To:     monstr@monstr.eu
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>,
        linux-metag@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 12 Nov 2013 10:55:11 -0500
In-Reply-To: <52824BBC.9020401@monstr.eu>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
         <52824BBC.9020401@monstr.eu>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Return-Path: <msalter@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msalter@redhat.com
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

On Tue, 2013-11-12 at 16:39 +0100, Michal Simek wrote:
> On 11/12/2013 02:22 PM, Mark Salter wrote:
> > 
> >  arch/arm/include/asm/fixmap.h        |  25 ++------
> >  arch/hexagon/include/asm/fixmap.h    |  40 +------------
> >  arch/metag/include/asm/fixmap.h      |  32 +----------
> >  arch/microblaze/include/asm/fixmap.h |  44 +-------------
> >  arch/mips/include/asm/fixmap.h       |  33 +----------
> >  arch/powerpc/include/asm/fixmap.h    |  44 +-------------
> >  arch/sh/include/asm/fixmap.h         |  39 +------------
> >  arch/tile/include/asm/fixmap.h       |  33 +----------
> >  arch/um/include/asm/fixmap.h         |  40 +------------
> >  arch/x86/include/asm/fixmap.h        |  59 +------------------
> >  include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++++++++++++
> >  11 files changed, 125 insertions(+), 371 deletions(-)
> >  create mode 100644 include/asm-generic/fixmap.h
> 
> Any repo/branch with all these patches will be helpful.

https://github.com/mosalter/linux (fixmap branch)
