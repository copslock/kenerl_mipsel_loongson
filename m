Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 15:49:53 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:54852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993928AbdEXNtfkFHgx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 May 2017 15:49:35 +0200
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE46CC04B94B;
        Wed, 24 May 2017 13:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com EE46CC04B94B
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=dhowells@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com EE46CC04B94B
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 418737F39D;
        Wed, 24 May 2017 13:49:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     dhowells@redhat.com, monstr@monstr.eu, ralf@linux-mips.org,
        liqin.linux@gmail.com, lennox.wu@gmail.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Unify the various copies of libgcc into lib
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23395.1495633764.1@warthog.procyon.org.uk>
Date:   Wed, 24 May 2017 14:49:24 +0100
Message-ID: <23396.1495633764@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 24 May 2017 13:49:29 +0000 (UTC)
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57986
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

Palmer Dabbelt <palmer@dabbelt.com> wrote:

> ... Unfortunately I don't actually have all these cross compilers setup...

If you have Fedora, you have the following available as standard RPMs:

	gcc-aarch64-linux-gnu
	gcc-alpha-linux-gnu
	gcc-arm-linux-gnu
	gcc-avr32-linux-gnu
	gcc-bfin-linux-gnu
	gcc-c6x-linux-gnu
	gcc-cris-linux-gnu
	gcc-frv-linux-gnu
	gcc-h8300-linux-gnu
	gcc-hppa-linux-gnu
	gcc-hppa64-linux-gnu
	gcc-ia64-linux-gnu
	gcc-m32r-linux-gnu
	gcc-m68k-linux-gnu
	gcc-microblaze-linux-gnu
	gcc-mips64-linux-gnu
	gcc-mn10300-linux-gnu
	gcc-nios2-linux-gnu
	gcc-powerpc64-linux-gnu
	gcc-ppc64-linux-gnu
	gcc-s390x-linux-gnu
	gcc-sh-linux-gnu
	gcc-sparc64-linux-gnu
	gcc-tile-linux-gnu
	gcc-xtensa-linux-gnu

They're built from the same sources as the gcc rpm (and the matching binutils
cross rpms are built from the same sources as the binutils rpm) - it's only
the spec file that's different, and they lag a bit behind the core
gcc/binutils as they only get updated after those change.

So in Fedora 25 these are all gcc-6 and in Fedora 26 they're all gcc-7.

David
