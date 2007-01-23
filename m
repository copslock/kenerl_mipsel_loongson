Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 13:18:23 +0000 (GMT)
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18698 "EHLO
	spitz.ucw.cz") by ftp.linux-mips.org with ESMTP id S20048165AbXAXNST
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 13:18:19 +0000
Received: by spitz.ucw.cz (Postfix, from userid 0)
	id 9DCE62787E; Tue, 23 Jan 2007 14:36:15 +0000 (UTC)
Date:	Tue, 23 Jan 2007 14:36:14 +0000
From:	Pavel Machek <pavel@ucw.cz>
To:	Alexey Dobriyan <adobriyan@gmail.com>
Cc:	akpm@osdl.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] seq_file conversion: APM on mips
Message-ID: <20070123143614.GA6596@ucw.cz>
References: <20070115211413.GB5010@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115211413.GB5010@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.9i
Return-Path: <root@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

Hi!

> @@ -456,14 +456,26 @@ static int apm_get_info(char *buf, char 
>  	case 1: 	units = "sec";	break;
>  	}
>  
> -	ret = sprintf(buf, "%s 1.2 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
> +	seq_printf(m, "%s 1.2 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
>  		     driver_version, APM_32_BIT_SUPPORT,
>  		     info.ac_line_status, info.battery_status,
>  		     info.battery_flag, info.battery_life,
>  		     info.time, units);
> +	return 0;
> +}
>  
> - 	return ret;
> +static int proc_apm_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, proc_apm_show, NULL);
>  }
> +
> +static const struct file_operations proc_apm_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= proc_apm_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
>  #endif
>  
>  static int kapmd(void *arg)

Perhaps now is good time to make the code shared?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
