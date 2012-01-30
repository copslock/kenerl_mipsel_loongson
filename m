Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2012 15:23:53 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:6372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903686Ab2A3OXs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jan 2012 15:23:48 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0UENgM6001763
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 30 Jan 2012 09:23:42 -0500
Received: from redhat.com (vpn-203-146.tlv.redhat.com [10.35.203.146])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id q0UENTK3007613;
        Mon, 30 Jan 2012 09:23:31 -0500
Date:   Mon, 30 Jan 2012 16:25:57 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shane McDonald <mcdonald.shane@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH 1/3] lib: add NO_GENERIC_PCI_IOPORT_MAP
Message-ID: <20120130142557.GA7382@redhat.com>
References: <cover.1327877053.git.mst@redhat.com>
 <d78d91d0166651700cf662a50c87d84da4bdab88.1327877053.git.mst@redhat.com>
 <CACoURw6docF1E4KwvfAAwh3GG0KFo15erj+JJwu0HHB-wtswig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACoURw6docF1E4KwvfAAwh3GG0KFo15erj+JJwu0HHB-wtswig@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-archive-position: 32327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Jan 30, 2012 at 08:19:31AM -0600, Shane McDonald wrote:
> Just a minor nit on the comment:
> 
> On Mon, Jan 30, 2012 at 6:18 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Some architectures need to override the way
> > IO port mapping is does not PCI devices.
> 
> Should this line read "IO port mapping is done on PCI devices."?

Right, good catch. I'll fix this up in git.

> > Supply a generic function that calls
> > ioport_map, and make it possible for architectures
> > to override.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Shane
