Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 03:11:39 +0100 (BST)
Received: from www.haninternet.co.kr ([211.63.64.4]:27908 "EHLO
	www.haninternet.co.kr") by ftp.linux-mips.org with ESMTP
	id S8133522AbWC0CLa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Mar 2006 03:11:30 +0100
Received: from [211.63.70.179] ([211.63.70.179])
	by www.haninternet.co.kr (8.9.3/8.9.3) with ESMTP id LAA31496
	for <linux-mips@linux-mips.org>; Mon, 27 Mar 2006 11:19:32 +0900
Subject: socket error
From:	Gowri Satish Adimulam <gowri@bitel.co.kr>
Reply-To: gowri@bitel.co.kr
To:	linux-mips@linux-mips.org
In-Reply-To: <20060325175042.GH6100@flint.arm.linux.org.uk>
References: <20060303140428.T96056@invalid.ed.ntnu.no>
	 <20060325175042.GH6100@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Bitel Co Ltd
Date:	Mon, 27 Mar 2006 11:21:41 +0900
Message-Id: <1143426101.3028.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Return-Path: <gowri@bitel.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gowri@bitel.co.kr
Precedence: bulk
X-list: linux-mips

Hi all ,
Below iam trying to run ftp server daemon , 
it gave below message , 

# ./ftpd
421 Cannot getsockname( STDIN ), errno=95
May  6 05:55:54 in.ftpd[48]: Cannot getsockname( STDIN ): Socket
operation on nt#

any idea about this error .

Regards
Gowri 
