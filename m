Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2008 01:13:01 +0100 (BST)
Received: from terminus.zytor.com ([198.137.202.10]:55455 "EHLO
	terminus.zytor.com") by ftp.linux-mips.org with ESMTP
	id S20874975AbYJHAMz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Oct 2008 01:12:55 +0100
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m980CjE2003674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Oct 2008 17:12:46 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m980CjRK023932;
	Tue, 7 Oct 2008 17:12:45 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m980CiWu015981;
	Tue, 7 Oct 2008 17:12:44 -0700
Message-ID: <48EBFAFC.3020501@zytor.com>
Date:	Tue, 07 Oct 2008 17:12:44 -0700
From:	"H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH 1/4] serial: 8250 driver replaceable i/o functions.
References: <48EBF426.9080500@caviumnetworks.com> <48EBF56D.3030203@caviumnetworks.com>
In-Reply-To: <48EBF56D.3030203@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.93.3/8387/Tue Oct  7 08:37:07 2008 on terminus.zytor.com
X-Virus-Status:	Clean
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> /* sane hardware needs no mapping */
> -static inline int map_8250_in_reg(struct uart_8250_port *up, int offset)
> +static inline int map_8250_in_reg(struct uart_port *p, int offset)
> {
> -    if (up->port.iotype != UPIO_AU)
> +    if (p->iotype != UPIO_AU)
>         return offset;
>     return au_io_in_map[offset];
> }

With your changes, these functions cannot be called with p->iotype != 
UPIO_AU anymore, correct?  So there is no need for this test...

	-hpa
