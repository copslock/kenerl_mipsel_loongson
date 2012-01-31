Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 17:00:09 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.17.8]:49294 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904020Ab2AaQAD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2012 17:00:03 +0100
Received: from klappe2.localnet (deibp9eh1--blueice3n2.emea.ibm.com [195.212.29.180])
        by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
        id 0Ll22r-1SSxmE1vRV-00aNLU; Tue, 31 Jan 2012 16:59:27 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] lib: add NO_GENERIC_PCI_IOPORT_MAP
Date:   Tue, 31 Jan 2012 15:59:25 +0000
User-Agent: KMail/1.12.2 (Linux/3.3.0-rc1; KDE/4.3.2; x86_64; ; )
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Myron Stowe <myron.stowe@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Dmitry Kasatkin <dmitry.kasatkin@intel.com>,
        James Morris <jmorris@namei.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        Michael Witten <mfwitten@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <cover.1327877053.git.mst@redhat.com> <201201302004.33083.arnd@arndb.de> <20120131002203.GA14344@redhat.com>
In-Reply-To: <20120131002203.GA14344@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201311559.26050.arnd@arndb.de>
X-Provags-ID: V02:K0:5unnTK8DY+pSXKJjyVKmUK1M6m9dlrxePP5EZqGBVFx
 QV18CtY7T6d+IeJJJCq+wVShQDnjlxVKGldTEfJ6eC1v9TFKmP
 o2FeUeWbWWqp3OZsOc2o4RxadowXInGyAfwtalJ45rdjt2m2WH
 A+KS3h1YHN1dSObRrAJBpwLYM0Ru8Y0JXVpzQfy83dzm+fvFhX
 Qtd0djvLe8cCqYjsvEw3XY93Mqn6q23+1WXSCgZ54sexf5RZ+o
 /T1A3ia82jgv68qmhofYwcvAryFZeX4lk5oNTxH7aAAzybFbhv
 1N10cSAbaaZ1UimrWldnaKIEahh5JKXKPPfHtSEg1dJXn5z3+6
 N4aDMWITUjtA2IreCvdk=
X-archive-position: 32364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tuesday 31 January 2012, Michael S. Tsirkin wrote:
> I have an idea: we can make the generic one inline
> if we keep it in the .c file. So something like
> the below on top of my patch will probably work.
> Ack?

IMHO this is still worse than the macro, because it breaks common practice.
The common way to do this is #ifdef/#else/#endif in the header file to
provide either an extern or a macro/inline definition, while having the
inline definition in a separate place makes it harder to understand
what's going on. E.g. a frequent review comment is to not put extern
declarations inside of #ifdef, but if someone tries that here, it would
break.

You also still need the #ifdef in the implementation file, which we
try to avoid normally just like we try to avoid macros where possible.

	Arnd
