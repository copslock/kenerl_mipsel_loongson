Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Mar 2003 15:56:52 +0000 (GMT)
Received: from [IPv6:::ffff:62.116.167.108] ([IPv6:::ffff:62.116.167.108]:55261
	"EHLO oricom4.internetx.de") by linux-mips.org with ESMTP
	id <S8225193AbTCKP4v>; Tue, 11 Mar 2003 15:56:51 +0000
Received: from mycable.de (pD9E3CF88.dip.t-dialin.net [217.227.207.136])
	(authenticated bits=0)
	by oricom4.internetx.de (8.12.8/8.12.8) with ESMTP id h2BFrV9h029391;
	Tue, 11 Mar 2003 16:53:32 +0100
Message-ID: <3E6E07D5.60306@mycable.de>
Date: Tue, 11 Mar 2003 16:59:17 +0100
From: Tiemo Krueger - mycable GmbH <tk@mycable.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bruno randolf <br1@4g-systems.biz>
CC: linux-mips@linux-mips.org
Subject: Re: Mycable XXS board
References: <3E689267.3070509@prosyst.bg> <20030307133919.P26071@mvista.com>	 <3E691514.7000907@embeddededge.com>  <200303111130.57387.br1@4g-systems.de> <1047395856.5198.127.camel@zeus.mvista.com>
In-Reply-To: <3E689267.3070509@prosyst.bg>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tk@mycable.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tk@mycable.de
Precedence: bulk
X-list: linux-mips

Hi Bruno, Hi group!

There is a separate power switch on the mycable XXS1500 Board:

1. GPIO1  switch on UART3
2.  Enable UART3
3.  Set DTR from UART3 to low-level

The voltage switch for USB is controlled by the unused DTR line of the 
Au1500.

below the code we use with QNX for this procedure:

/*-------------------------------------------------------------------------*/
/*                                                                         
*/
/*  
main                                                                   */
/*                                                                         
*/
/*  action: enable and start AU1500 onchip USB 
controller                  */
/*                                                                         
*/
/*  passing param.  : 
-none-                                               */
/*  global  param.  : 
-none-                                               */
/*  return  param.  : 
-none-                                               */
/*                                                                         
*/
/*  programmer      : 
JR                                                   */
/*                                                                         
*/
/*  04.03.03  JR    : build this 
function                                  */
/*                                                                         
*/
/*-------------------------------------------------------------------------*/

int main(int argc, char *argv[]) {
   
    volatile uint32_t *sysctrlptr;
    volatile uint32_t *uart3_mdmptr;
    volatile uint32_t *usb_baseptr;
   
   
    printf("Prepare AU1500 onchip USB host controller\n");
    printf("  map memory\n");
    sysctrlptr = mmap_device_memory(NULL, 1000, 
PROT_READ|PROT_WRITE|PROT_NOCACHE, 0, 0x011900000);
    if ( sysctrlptr == MAP_FAILED ) {
        perror( "couldn't map sysctrl mem.\n" );
        exit( EXIT_FAILURE );
    }
    uart3_mdmptr = mmap_device_memory(NULL, 1000, 
PROT_READ|PROT_WRITE|PROT_NOCACHE, 0, 0x011400000);
    if ( uart3_mdmptr == MAP_FAILED ) {
        perror( "couldn't map uart3 mem.\n" );
        exit( EXIT_FAILURE );
    }
    usb_baseptr = mmap_device_memory(NULL, 0x80000, 
PROT_READ|PROT_WRITE|PROT_NOCACHE, 0, 0x010100000);
    if ( usb_baseptr == MAP_FAILED ) {
        perror( "couldn't map usb mem.\n" );
        exit( EXIT_FAILURE );
    }

    // configure some multiple use pins for UART3
    sysctrlptr[0x2c/4] |= (1 << 7);  // sys_pinctrl
   
    printf("  power on\n");
    uart3_mdmptr[0x100/4] |= 0x01;    // CE
    delay(10);
    uart3_mdmptr[0x100/4] |= 0x03;    // CE | EN
    delay(10);
    uart3_mdmptr[0x18/4]  |= 0x01;    // power on
   
    // enable usb OCHI controller
    usb_baseptr[0x7fffc/4] = 0x08;    // CE
    delay(10);
    usb_baseptr[0x7fffc/4] = 0x0c ;    // CE | EN
    delay(10);
    // clear HCFS bits in HcControl
    usb_baseptr[0x0004/4] = 0x00; 
   
    while ((usb_baseptr[0x7fffc/4] & 0x10) == 0); // wait for reset done
   
    printf("  USB OHCI ver. 0x%x\n", usb_baseptr[0]);
   
    return EXIT_SUCCESS;
}

Tiemo

-- 
-------------------------------------------------------
Tiemo Krueger       Tel:  +49 48 73 90 19 86
mycable GmbH        Fax: +49 48 73 90 19 76
Boeker Stieg 43
D-24613 Aukrug      eMail: tk@mycable.de

Public Kryptographic Key is available on request
-------------------------------------------------------


Pete Popov wrote:

>On Tue, 2003-03-11 at 02:30, Bruno Randolf wrote:
>  
>
>>On Friday 07 March 2003 22:54, Dan Malek wrote:
>>
>>    
>>
>>>That's what I wanted to clarify.  Are we discussing one of the on-chip
>>>peripheral USB controllers of the Au1xxx, or is it a PCI USB controller
>>>that was plugged into the Au1500.  In the case of the on-chip controller,
>>>there aren't any interrupt routing problems, it's identical (and the same
>>>code) on all Au1xxx boards.
>>>      
>>>
>>we are discussing the on-chip USB controller for the mycable board. and its 
>>little endian...
>>
>>any ideas where the assignment errors could come from in this case?
>>    
>>
>
>There wouldn't be any. So the problem is not irq assignment related.
>
>I'm not what to suggest here but it feels like it might be a hardware
>issue.  Try adding some printks (the abatron bdi jtag debugger works
>great if you have one) and narrow down what's going on. Do you have any
>jumpers on the board that are not setup correctly?
>
>
>Pete
>
>
>
>  
>


-- 
-------------------------------------------------------
Tiemo Krueger       Tel:  +49 48 73 90 19 86
mycable GmbH        Fax: +49 48 73 90 19 76
Boeker Stieg 43
D-24613 Aukrug      eMail: tk@mycable.de

Public Kryptographic Key is available on request
-------------------------------------------------------
