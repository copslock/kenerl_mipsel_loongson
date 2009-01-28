Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 12:40:52 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:12489 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21103511AbZA1Mku (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Jan 2009 12:40:50 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0SCenB5028009;
	Wed, 28 Jan 2009 12:40:49 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0SCelpK028000;
	Wed, 28 Jan 2009 12:40:47 GMT
Date:	Wed, 28 Jan 2009 12:40:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add return value check to
	user_termio_to_kernel_termios()
Message-ID: <20090128124047.GA25706@linux-mips.org>
References: <20090125224557.8582051b.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090125224557.8582051b.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 25, 2009 at 10:45:57PM +0900, Yoichi Yuasa wrote:

> diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/include/asm/termios.h linux/arch/mips/include/asm/termios.h
> --- linux-orig/arch/mips/include/asm/termios.h	2008-10-19 22:33:14.114377349 +0900
> +++ linux/arch/mips/include/asm/termios.h	2008-10-19 22:41:25.322369698 +0900
> @@ -97,14 +97,14 @@ struct termio {
>  #define user_termio_to_kernel_termios(termios, termio) \
>  ({ \
>  	unsigned short tmp; \
> -	get_user(tmp, &(termio)->c_iflag); \
> -	(termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
> -	get_user(tmp, &(termio)->c_oflag); \
> -	(termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
> -	get_user(tmp, &(termio)->c_cflag); \
> -	(termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
> -	get_user(tmp, &(termio)->c_lflag); \
> -	(termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
> +	if (!get_user(tmp, &(termio)->c_iflag)) \
> +		(termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
> +	if (!get_user(tmp, &(termio)->c_oflag)) \
> +		(termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
> +	if (!get_user(tmp, &(termio)->c_cflag)) \
> +		(termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
> +	if (!get_user(tmp, &(termio)->c_lflag)) \
> +		(termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
>  	get_user((termios)->c_line, &(termio)->c_line); \
>  	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \

Duh...  That sort of trivial thing is not fatal but just shouldn't
happen.  And other architectures have the same bug even.  Your patch
leaves the last get_user and the copy_from_user return values unchecked.
I'll sort that out.

Thanks for reporting and patch!

  Ralf
