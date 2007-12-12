Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 17:28:11 +0000 (GMT)
Received: from host188-210-dynamic.20-79-r.retail.telecomitalia.it ([79.20.210.188]:40683
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20034556AbXLLR2B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 17:28:01 +0000
Received: from 89-96-243-184.ip14.fastwebnet.it ([89.96.243.184] helo=[192.168.215.30])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1J2VK2-0006eo-CP; Wed, 12 Dec 2007 18:24:40 +0100
Subject: Re: 2.6.24-rc2 crash in kmap_coherent
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	David Daney <ddaney@avtrex.com>
In-Reply-To: <1197479471.25499.48.camel@scarafaggio>
References: <20071211221327.GB2150@paradigm.rfc822.org>
	 <20071212120610.GB28868@linux-mips.org>
	 <20071212153218.GA30291@linux-mips.org>
	 <1197479471.25499.48.camel@scarafaggio>
Content-Type: text/plain
Date:	Wed, 12 Dec 2007 18:25:32 +0100
Message-Id: <1197480332.25499.50.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mer, 12/12/2007 alle 18.11 +0100, Giuseppe Sacco ha scritto:
> Hi Ralf,
> the change you proposed here give an error since "page" is onlt
> available on function copy_user_highpage() while there is not such
> variable (nor parameter) in function copy_to_user_page().
[...]

Sorry, I meant the variable "from", not "page".
