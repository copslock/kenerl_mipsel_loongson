Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 22:46:27 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:57362 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133716AbWEJUqU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 May 2006 22:46:20 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 2B3D864D54; Wed, 10 May 2006 20:46:12 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id CE23B66B6D; Wed, 10 May 2006 22:46:01 +0200 (CEST)
Date:	Wed, 10 May 2006 22:46:01 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	karsten@excalibur.cologne.de
Cc:	linux-mips@linux-mips.org
Subject: pmag* drivers don't build on 2.6
Message-ID: <20060510204601.GA23786@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

The pmag* fb drivers (DECstation) don't build on 2.6.  Can someone
port them to the 2.6 api (and possibly merge both files into one)?
Karsten?
-- 
Martin Michlmayr
http://www.cyrius.com/
