Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Dec 2004 02:36:22 +0000 (GMT)
Received: from imfep02.dion.ne.jp ([IPv6:::ffff:210.174.120.146]:33578 "EHLO
	imfep02.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8225074AbULNCgR>; Tue, 14 Dec 2004 02:36:17 +0000
Received: from webmail.dion.ne.jp ([210.196.2.172]) by imfep02.dion.ne.jp
          (InterMail vM.4.01.03.31 201-229-121-131-20020322) with SMTP
          id <20041214023558.UPTE1125.imfep02.dion.ne.jp@webmail.dion.ne.jp>;
          Tue, 14 Dec 2004 11:35:58 +0900
From: ichinoh@mb.neweb.ne.jp
To: linux-mips@linux-mips.org
Cc: ichinoh@mb.neweb.ne.jp
Date: Tue, 14 Dec 2004 11:35:58 +0900
Message-Id: <1102991758.2865@157.120.127.3.DIONWebMail>
Subject: UART3 of DbAu1100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
X-Mailer: DION Web mail version 1.03
X-Originating-IP: 157.120.127.3(*)
Return-Path: <ichinoh@mb.neweb.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ichinoh@mb.neweb.ne.jp
Precedence: bulk
X-list: linux-mips

Hello,

I have a question about UART3 of DbAu1100.

After enabling UART3 then reboot the kernel, I cannot use UART3 port.
Did anyone encounter the same error ?
In addition, UART3 initialization processing is as follows.

static int serial_init (void)
{
	volatile u32 *uart_fifoctl = (volatile u32*)(UART3_ADDR+UART_FCR);
	volatile u32 *uart_enable = (volatile u32*)(UART3_ADDR+UART_ENABLE);
	volatile u32 *uart_mcr = (volatile u32*)(UART3_ADDR+UART_MCR);
	volatile u32 *sys_pinfunc = (volatile u32*)SYS_PINFUNC;

	/* reset UART0 module */
	au_writel(0x00, UART3_ADDR);
	au_sync( );

	/* Enable clocks first */
	*uart_enable = UART_EN_CE;

	/* Then release reset */
	/* Must release reset before setting other regs */
	*uart_enable = UART_EN_CE|UART_EN_E;

	/* Activate fifos, reset tx and rx */
	/* Set tx trigger level to 12 */
	*uart_fifoctl = UART_FCR_ENABLE_FIFO|UART_FCR_CLEAR_RCVR|             
	UART_FCR_CLEAR_XMIT|UART_FCR_T_TRIGGER_12|UART_FCR_R_TRIGGER_14; 

	serial_setbrg( );
	
	/* Set DTR */
	*uart_mcr = UART_MCR_DTR | UART_MCR_RTS;

	return 0;
}

static void serial_setbrg (void)
{
	volatile u32 *uart_clk = (volatile u32*)(UART3_ADDR+UART_CLK);
	volatile u32 *uart_lcr = (volatile u32*)(UART3_ADDR+UART_LCR);

	/* Set baudrate to 9600 */
	*uart_clk = 0x280;

	/* Set parity, stop bits and word length to 8N1 */
	*uart_lcr = UART_LCR_WLEN8;
	return ;
}

Best regards,
Nyauyama.
