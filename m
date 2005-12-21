Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 10:01:34 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:19374 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S3458549AbVLUKBN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Dec 2005 10:01:13 +0000
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 21689C068;
	Wed, 21 Dec 2005 11:02:17 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id 5E9F31BC087;
	Wed, 21 Dec 2005 11:02:19 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 7D5AD1A18AD;
	Wed, 21 Dec 2005 11:02:19 +0100 (CET)
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20051221091852.GT13985@lug-owl.de>
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
	 <20051221085539.GS13985@lug-owl.de>
	 <50c9a2250512210104j4a19e37cu30c795d4acc226d2@mail.gmail.com>
	 <20051221091852.GT13985@lug-owl.de>
Content-Type: text/plain
Date:	Wed, 21 Dec 2005 11:02:34 +0100
Message-Id: <1135159354.5211.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> As a good starting point, go to http://www.kegel.com/crosstool/ .

Yes, we use crosstool, but the results matrix isn't rely
encouraging:
http://www.kegel.com/crosstool/crosstool-0.38/buildlogs/

BR,
Matej
