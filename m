Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2005 20:25:59 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:49844 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225370AbVAXUZo>; Mon, 24 Jan 2005 20:25:44 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0OKMit7002581;
	Mon, 24 Jan 2005 20:22:44 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j0OKMiWN002580;
	Mon, 24 Jan 2005 20:22:44 GMT
Date:	Mon, 24 Jan 2005 20:22:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] TX4927 processor can support different speeds
Message-ID: <20050124202244.GB2376@linux-mips.org>
References: <20050123192318.GA22681@prometheus.mvista.com> <20050123194140.GL15265@rembrandt.csv.ica.uni-stuttgart.de> <20050123195129.GA1806@linux-mips.org> <41F40B8E.2080003@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F40B8E.2080003@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 23, 2005 at 12:39:42PM -0800, Manish Lachwani wrote:

> Why is this approach (in the patch) bad?

It's fragile because clock frequencies are changing faster in today's
world of electronics than the weather in April.

  Ralf
