Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jan 2005 19:41:58 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:51048
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224920AbVAWTly>; Sun, 23 Jan 2005 19:41:54 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CsncD-0005VS-00; Sun, 23 Jan 2005 20:41:41 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CsncC-0007yq-00; Sun, 23 Jan 2005 20:41:40 +0100
Date:	Sun, 23 Jan 2005 20:41:40 +0100
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] TX4927 processor can support different speeds
Message-ID: <20050123194140.GL15265@rembrandt.csv.ica.uni-stuttgart.de>
References: <20050123192318.GA22681@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123192318.GA22681@prometheus.mvista.com>
User-Agent: Mutt/1.5.6+20040907i
From:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Manish Lachwani wrote:
> Hi Ralf,
> 
> Based on the feedback from Toshiba, the TX4927 processor can support different 
> speeds. Attached patch takes care of that. If you find this approach reasonable, 
> can you please check it in

Shoudn't this better be tunable via /proc?


Thiemo
