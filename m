Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 08:19:09 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:12664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816285Ab3FJGTHzAbAQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 08:19:07 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5A6IqjN016471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 10 Jun 2013 02:18:52 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r5A6Io6m006925;
        Mon, 10 Jun 2013 02:18:51 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 7749918D3DE; Mon, 10 Jun 2013 09:18:49 +0300 (IDT)
Date:   Mon, 10 Jun 2013 09:18:49 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     David Daney <david.s.daney@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via
 the MIPS-VZ extensions.
Message-ID: <20130610061849.GX4725@redhat.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <51B26974.5000306@caviumnetworks.com>
 <20130609073115.GE4725@redhat.com>
 <51B50E87.2060501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51B50E87.2060501@gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Sun, Jun 09, 2013 at 04:23:51PM -0700, David Daney wrote:
> On 06/09/2013 12:31 AM, Gleb Natapov wrote:
> >On Fri, Jun 07, 2013 at 04:15:00PM -0700, David Daney wrote:
> >>I should also add that I will shortly send patches for the kvm tool
> >>required to drive this VM as well as a small set of patches that
> >>create a para-virtualized MIPS/Linux guest kernel.
> >>
> >>The idea is that because there is no standard SMP linux system, we
> >>create a standard para-virtualized system that uses a handful of
> >>hypercalls, but mostly just uses virtio devices.  It has no emulated
> >>real hardware (no 8250 UART, no emulated legacy anything...)
> >>
> >Virtualization is useful for running legacy code. Why dismiss support
> >for non pv guests so easily?
> 
> Just because we create standard PV system devices, doesn't preclude
> emulating real hardware.  In fact Sanjay Lal's work includes QEMU
> support for doing just this for a MIPS malta board.  I just wanted a
> very simple system I could implement with the kvm tool in a couple
> of days, so that is what I initially did.
> 
That makes sense. From your wording I misunderstood that there is something
in proposed patches that requires PV to run a guest.

--
			Gleb.
