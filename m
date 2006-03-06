Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2006 03:42:54 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:14596 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133566AbWCGDmm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Mar 2006 03:42:42 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6FA5464D3D; Tue,  7 Mar 2006 03:51:02 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 9BDEE66D0E; Tue,  7 Mar 2006 03:50:48 +0000 (GMT)
Resent-From: tbm@cyrius.com
Resent-Date: Tue, 7 Mar 2006 03:50:48 +0000
Resent-Message-ID: <20060307035048.GA22201@deprecation.cyrius.com>
Resent-To: linux-mips@linux-mips.org
Received: by deprecation.cyrius.com (Postfix, from userid 10)
	id 02AB366EBE; Mon,  6 Mar 2006 23:19:10 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by sorrow.cyrius.com (Postfix) with ESMTP id 7E21F64D3F
	for <tbm@cyrius.com>; Mon,  6 Mar 2006 23:15:59 +0000 (UTC)
Received: from fr.zoreil.com (electric-eye.fr.zoreil.com [213.41.134.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sorrow.cyrius.com (Postfix) with ESMTP id 33F5064D3D
	for <tbm@cyrius.com>; Mon,  6 Mar 2006 23:15:54 +0000 (UTC)
Received: from electric-eye.fr.zoreil.com (localhost.localdomain [127.0.0.1])
	by fr.zoreil.com (8.13.4/8.12.1) with ESMTP id k26NFUkL021899;
	Tue, 7 Mar 2006 00:15:30 +0100
Received: (from romieu@localhost)
	by electric-eye.fr.zoreil.com (8.13.4/8.12.1) id k26NFUYZ021898;
	Tue, 7 Mar 2006 00:15:30 +0100
Date:	Tue, 7 Mar 2006 00:15:30 +0100
From:	Francois Romieu <romieu@fr.zoreil.com>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH, RESEND] Add MWI workaround for Tulip DC21143
Message-ID: <20060306231530.GB16082@electric-eye.fr.zoreil.com>
References: <20060129230816.GD4094@colonel-panic.org> <20060218220851.GA1601@colonel-panic.org> <20060306225131.GA23327@unjust.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306225131.GA23327@unjust.cyrius.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation:	Land of Sunshine Inc.
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cyrius.com
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Martin Michlmayr <tbm@cyrius.com> :
[...]
> Does anyone have comments regarding this patch?  I received
> confirmation from a number of Debian users that this patch
> significantly improves the lockup situation on Cobalt, so
> it would be nice if it could go in.

I'll queue it with the pending de2104x fix(es ?) during my next
upkeep.

-- 
Ueimor
