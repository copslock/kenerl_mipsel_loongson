Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 23:55:04 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:50445 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133725AbWBSXy4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 23:54:56 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 121E264D3D; Mon, 20 Feb 2006 00:01:49 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id E63BA8D5D; Mon, 20 Feb 2006 00:01:41 +0000 (GMT)
Date:	Mon, 20 Feb 2006 00:01:41 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	ppopov@mvista.com, dtor_core@ameritech.net
Subject: Re: Diff between Linus' and linux-mips git: small changes
Message-ID: <20060220000141.GX10266@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219234318.GA16311@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I noticed the following difference between the Linus and the
linux-mips tree.  Who is correct and can the other one be changed
please?

--- linux-2.6.16-rc4/drivers/char/qtronix.c	2006-02-19 20:08:44.000000000 +0000
+++ mips-2.6.16-rc4/drivers/char/qtronix.c	2006-02-19 20:15:07.000000000 +0000
@@ -535,8 +535,7 @@
 		i--;
 	}
 	if (count-i) {
-		struct inode *inode = file->f_dentry->d_inode;
-		inode->i_atime = current_fs_time(inode->i_sb);
+		file->f_dentry->d_inode->i_atime = get_seconds();
 		return count-i;
 	}
 	if (signal_pending(current))

-- 
Martin Michlmayr
http://www.cyrius.com/
