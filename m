Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g24MXkQ00892
	for linux-mips-outgoing; Mon, 4 Mar 2002 14:33:46 -0800
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g24MXh900889
	for <linux-mips@oss.sgi.com>; Mon, 4 Mar 2002 14:33:43 -0800
Received: from excalibur.cologne.de (pD9E40956.dip.t-dialin.net [217.228.9.86])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id WAA15181
	for <linux-mips@oss.sgi.com>; Mon, 4 Mar 2002 22:33:40 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16i03B-00005J-00
	for <linux-mips@oss.sgi.com>; Mon, 04 Mar 2002 22:31:17 +0100
Date: Mon, 4 Mar 2002 22:31:17 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: Re: Compressed images?
Message-ID: <20020304223117.B254@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
References: <20020304120803.A1247@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020304120803.A1247@ayrnetworks.com>; from wjhun@ayrnetworks.com on Mon, Mar 04, 2002 at 12:08:03PM -0800
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Mar 04, 2002 at 12:08:03PM -0800, William Jhun wrote:

> Should we be placing our boot image compression stuff in our
> platform-specific directory? Are most MIPS-based Linux platforms not
> using compressed images?

I cannot speak for "most" platforms, but at least the DECstations
and the SGI IP22 (Indy and Indigo2) can only boot uncompressed images
currently, so it does not make sense to build compressed images for
them.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
