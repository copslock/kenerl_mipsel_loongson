Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2008 14:42:28 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:24819 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20021935AbYDQNm0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2008 14:42:26 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m3HDfLSo003649;
	Thu, 17 Apr 2008 06:41:21 -0700 (PDT)
Received: from [127.0.0.1] (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m3HDgHQD017894;
	Thu, 17 Apr 2008 06:42:17 -0700 (PDT)
Message-ID: <480753E6.3030402@mips.com>
Date:	Thu, 17 Apr 2008 15:43:02 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: Patches for 34K APRP
References: <4805FFE6.5080903@mips.com> <20080417132610.GB31453@linux-mips.org>
In-Reply-To: <20080417132610.GB31453@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Apr 16, 2008 at 03:32:22PM +0200, Kevin D. Kissell wrote:
>
>   
>> --- a/arch/mips/kernel/kspd.c
>> +++ b/arch/mips/kernel/kspd.c
>> @@ -257,7 +257,7 @@ void sp_work_handle_request(void)
>>  
>>  		vcwd = vpe_getcwd(tclimit);
>>  
>> - 		/* change to the cwd of the process that loaded the SP program */
>> + 		/* change to cwd of the process that loaded the SP program */
>>  		old_fs = get_fs();
>>  		set_fs(KERNEL_DS);
>>  		sys_chdir(vcwd);
>> @@ -323,6 +323,9 @@ static void sp_cleanup(void)
>>  			set >>= 1;
>>  		}
>>  	}
>> +
>> +	/* Put daemon cwd back to root to avoid umount problems */
>> +	sys_chdir("/");
>>     
>
> Still not kosher; there might be multiple roots on a system ...
>   
What do you suggest, then?  Leaving things as they are makes it impossible
to do a clean shutdown of an APRP system if the kspd was last used to 
support
an RP binary that was read from a mounted file system.  I respectfully 
submit
that it's at least an order of magnitude more likely that a mounted file 
system
will have been used than a chrooted, mounted file system.

          Regards,

          Kevin K.
