Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Apr 2013 00:07:51 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:33870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822998Ab3DPWHpqMeIM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Apr 2013 00:07:45 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3GM7eNB002708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 16 Apr 2013 18:07:40 -0400
Received: from warthog.procyon.org.uk (ovpn-113-46.phx2.redhat.com [10.3.113.46])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r3GM7bY5028972;
        Tue, 16 Apr 2013 18:07:38 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHGf_=r+qoL8_J+z8Y1uPt_NK1Ef4cLuapAvVd-7qF8+_oSjJw@mail.gmail.com>
References: <CAHGf_=r+qoL8_J+z8Y1uPt_NK1Ef4cLuapAvVd-7qF8+_oSjJw@mail.gmail.com> <20130416182550.27773.89310.stgit@warthog.procyon.org.uk> <20130416182601.27773.46395.stgit@warthog.procyon.org.uk>
To:     KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Cc:     dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, x86@kernel.org,
        sparclinux@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/28] proc: Split kcore bits from linux/procfs.h into linux/kcore.h [RFC]
Date:   Tue, 16 Apr 2013 23:07:37 +0100
Message-ID: <30949.1366150057@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36247
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


KOSAKI Motohiro <kosaki.motohiro@gmail.com> wrote:

> I have no seen any issue in this change. but why? Is there any
> motivation rather than cleanup?

Stopping stuff mucking about with the internals of procfs incorrectly
(sometimes because the internals of procfs have changed, but the drivers
haven't).

David
