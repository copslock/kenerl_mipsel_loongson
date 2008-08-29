Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2008 11:38:48 +0100 (BST)
Received: from smtp.nokia.com ([192.100.122.233]:44788 "EHLO
	mgw-mx06.nokia.com") by ftp.linux-mips.org with ESMTP
	id S20029010AbYH2Kio convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Aug 2008 11:38:44 +0100
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7TAcHsS009252;
	Fri, 29 Aug 2008 13:38:36 +0300
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by esebh107.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 13:38:35 +0300
Received: from vaebh101.NOE.Nokia.com ([10.160.244.22]) by esebh102.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 13:38:34 +0300
Received: from [172.21.40.50] ([172.21.40.50]) by vaebh101.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 13:38:34 +0300
Subject: Re: [PATCH] fs/ubifs: Use an IS_ERR test rather than a NULL test
From:	Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To:	Julien Brunel <brunel@diku.dk>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
In-Reply-To: <200808291108.32958.brunel@diku.dk>
References: <200808291108.32958.brunel@diku.dk>
Content-Type: text/plain; charset=utf-8
Date:	Fri, 29 Aug 2008 13:35:14 +0300
Message-Id: <1220006114.4036.16.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 29 Aug 2008 10:38:34.0768 (UTC) FILETIME=[63662100:01C909C3]
X-Nokia-AV: Clean
Return-Path: <dedekind@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind@infradead.org
Precedence: bulk
X-list: linux-mips

On Fri, 2008-08-29 at 11:08 +0200, Julien Brunel wrote:
> In case of error, the function kthread_create returns an ERR pointer,
> but never returns a NULL pointer. So a NULL test that comes before an
> IS_ERR test should be deleted.
> 
> The semantic match that finds this problem is as follows:
> (http://www.emn.fr/x-info/coccinelle/)

Pushed to ubifs-2.6.git, thanks.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)
