Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 00:07:07 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37852 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20031746AbYEMXHE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 May 2008 00:07:04 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4DN6hcD010876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 May 2008 16:06:44 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m4DN6gXM004388;
	Tue, 13 May 2008 16:06:42 -0700
Date:	Tue, 13 May 2008 16:06:42 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Matteo Croce <matteo@openwrt.org>
Cc:	jgarzik@pobox.com, ralf@linux-mips.org, nbd@openwrt.org,
	ejka@imfi.kspu.ru, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH]: cpmac bugfixes and enhancements
Message-Id: <20080513160642.a96dccbf.akpm@linux-foundation.org>
In-Reply-To: <200805140058.32890.matteo@openwrt.org>
References: <200805041904.22726.matteo@openwrt.org>
	<20080505161634.6964d46b.akpm@linux-foundation.org>
	<200805140058.32890.matteo@openwrt.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 May 2008 00:58:32 +0200 Matteo Croce <matteo@openwrt.org> wrote:

> This one is cleaner:
> 
> 
> Signed-off-by: Matteo Croce <matteo@openwrt.org>
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>

It has no changelog.  We can neither effectively review it nor commit
it without one.

Each bugfix and each enhancement should be described, please.
