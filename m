Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 20:45:04 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41157 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492618Ab0EDSpB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 May 2010 20:45:01 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o44Iiw5m026114;
        Tue, 4 May 2010 19:44:59 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o44IivN5026112;
        Tue, 4 May 2010 19:44:57 +0100
Date:   Tue, 4 May 2010 19:44:57 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
Message-ID: <20100504184457.GA21929@linux-mips.org>
References: <E1O8lDn-0000Sk-86@localhost>
 <4BDF366E.5000501@paralogos.com>
 <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>
 <4BDF8092.1060401@paralogos.com>
 <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>
 <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>
 <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>
 <4BE00207.6030506@paralogos.com>
 <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com>
 <4BE0479E.6060506@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BE0479E.6060506@paralogos.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 04, 2010 at 09:13:18AM -0700, Kevin D. Kissell wrote:

> What we used to use was what I *thought* was an old public domain
> program whose name was an English word that had something to do with
> being exacting.  Googling with obvious keywords didn't turn it up.

Is it paranoia by any chance?  Paranoia is available as single files at:

  http://www.math.utah.edu/~beebe/software/ieee/paranoia.c
  http://www.math.utah.edu/~beebe/software/ieee/paranoia.h

It's ages that soembody last ran it but last known status is that there
were no paranoia fault.

  Ralf
