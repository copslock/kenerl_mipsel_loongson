Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 13:42:05 +0100 (BST)
Received: from 87-237-56-54.northerncolo.co.uk ([87.237.56.54]:21917 "EHLO
	totally.trollied.org.uk") by ftp.linux-mips.org with ESMTP
	id S20021761AbXHAMmD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 13:42:03 +0100
Received: from localhost ([127.0.0.1] helo=totally.trollied.org.uk)
	by totally.trollied.org.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <movement@totally.trollied.org.uk>)
	id 1IGDTN-0007sU-N1; Wed, 01 Aug 2007 13:38:41 +0100
Received: (from movement@localhost)
	by totally.trollied.org.uk (8.13.7/8.13.7/Submit) id l71CcekF030283;
	Wed, 1 Aug 2007 13:38:40 +0100
Date:	Wed, 1 Aug 2007 13:38:40 +0100
From:	John Levon <levon@movementarian.org>
To:	Dajie Tan <jiankemeng@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>,
	oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH][resend] add support for profiling loongson2e
Message-ID: <20070801123840.GA29950@totally.trollied.org.uk>
References: <20070801130109.GA5170@sw-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070801130109.GA5170@sw-linux.com>
X-Url:	http://www.movementarian.org/
User-Agent: Mutt/1.5.9i
Return-Path: <movement@totally.trollied.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: levon@movementarian.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 01, 2007 at 05:01:09PM +0400, Dajie Tan wrote:

> diff --git a/drivers/oprofile/cpu_buffer.c b/drivers/oprofile/cpu_buffer.c
> index a83c3db..fde9819 100644
> --- a/drivers/oprofile/cpu_buffer.c
> +++ b/drivers/oprofile/cpu_buffer.c
> @@ -148,6 +148,10 @@ add_sample(struct oprofile_cpu_buffer * cpu_buf,
>             unsigned long pc, unsigned long event)
>  {
>  	struct op_sample * entry = &cpu_buf->buffer[cpu_buf->head_pos];
> +
> +	if(!entry)
> +		return;
> +

Perhaps I wasn't clear. This change is unacceptable and must not be
merged.

john
