Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 15:18:39 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:56556 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008858AbbCWOShtvMun (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 15:18:37 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 3D48D4605DF
        for <linux-mips@linux-mips.org>; Mon, 23 Mar 2015 14:18:33 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o8P6jlkLAwzX for <linux-mips@linux-mips.org>;
        Mon, 23 Mar 2015 14:18:27 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id ED04A460882
        for <linux-mips@linux-mips.org>; Mon, 23 Mar 2015 14:18:26 +0000 (GMT)
Received: from localhost ([::1] helo=paulmartin.codethink.co.uk)
        by pm-laptop.codethink.co.uk with esmtp (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1Ya3BS-00083L-BQ
        for linux-mips@linux-mips.org; Mon, 23 Mar 2015 14:18:26 +0000
Date:   Mon, 23 Mar 2015 14:18:26 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: OCTEON: Add mach-cavium-octeon/mangle-port.h
Message-ID: <20150323141825.GB19416@paulmartin.codethink.co.uk>
Mail-Followup-To: linux-mips@linux-mips.org
References: <1426867920-7907-1-git-send-email-aleksey.makarov@auriga.com>
 <1426867920-7907-3-git-send-email-aleksey.makarov@auriga.com>
 <55101D58.1050309@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55101D58.1050309@auriga.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

On Mon, Mar 23, 2015 at 05:04:08PM +0300, Aleksey Makarov wrote:

> With these patches the cn7000 board boots in little-endian mode with 
> all peripherials supported on this board working fine.  The peripherials
> on other boards should probably be fixed separately.

Including octeon-rng?  :-)

-- 
Paul Martin                                  http://www.codethink.co.uk/
Senior Software Developer, Codethink Ltd.
