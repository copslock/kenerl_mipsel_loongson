Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 18:56:47 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:42136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491022Ab1BOR4n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Feb 2011 18:56:43 +0100
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p1FHuPLJ030148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 15 Feb 2011 12:56:25 -0500
Received: from freie.oliva.athome.lsd.ic.unicamp.br (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p1FHuJHf002850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 15 Feb 2011 12:56:25 -0500
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
        by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p1FHuGaI022833;
        Tue, 15 Feb 2011 15:56:16 -0200
Received: from livre.localdomain (aoliva@localhost.localdomain [127.0.0.1])
        by livre.localdomain (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p1FHuC2x026366;
        Tue, 15 Feb 2011 15:56:12 -0200
Received: (from aoliva@localhost)
        by livre.localdomain (8.14.3/8.14.3/Submit) id p1FHu5pE026360;
        Tue, 15 Feb 2011 15:56:06 -0200
X-Authentication-Warning: livre.localdomain: aoliva set sender to aoliva@redhat.com using -f
From:   Alexandre Oliva <aoliva@redhat.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips <linux-mips@linux-mips.org>, GCC <gcc@gcc.gnu.org>,
        binutils <binutils@sourceware.org>,
        Prasun Kapoor <prasun.kapoor@caviumnetworks.com>
Subject: Re: RFC: A new MIPS64 ABI
Organization: Free thinker, does not speak for Red Hat
                or its Operating System Tools Group
References: <4D5990A4.2050308@caviumnetworks.com>
Date:   Tue, 15 Feb 2011 15:56:01 -0200
In-Reply-To: <4D5990A4.2050308@caviumnetworks.com> (David Daney's message of
        "Mon, 14 Feb 2011 12:29:24 -0800")
Message-ID: <orzkpx6v2m.fsf@livre.localdomain>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Feb 14, 2011, David Daney <ddaney@caviumnetworks.com> wrote:

> Current MIPS 32-bit ABIs (both o32 and n32) are restricted to 2GB of
> user virtual memory space.  This is due the way MIPS32 memory space is
> segmented.  Only the range from 0..2^31-1 is available.  Pointer
> values are always sign extended.

> The proposed new ABI would only be available on MIPS64 platforms.  It
> would be identical to the current MIPS n32 ABI *except* that pointers
> would be zero-extended rather than sign-extended when resident in
> registers.

FTR, I don't really know why my Yeeloong is limited to 31-bit addresses,
and I kind of hoped an n32 userland would improve that WRT o32, without
wasting memory with longer pointers like n64 would.

So, sorry if this is a dumb question, but wouldn't it be much easier to
keep on using sign-extended addresses, and just make sure the kernel
never allocates a virtual memory range that crosses a sign-bit change,
or whatever other reason there is for addresses to be limited to the
positive 2GB range in n32?

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
